class FixturesController < ApplicationController

    # GET /fixtures
    # GET /fixtures.json
    def index
       #   @fixtures = Fixture.where(:game_id => (params[:game_id]))
            @fixtures = Fixture.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fixtures }
      end
    end
    
     def fix_by_comp
            @fixtures = Fixture.all
            @fixtures_by_comp = @fixtures.group_by { |t| t.game_id }
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @fixtures }
        end
      end
    
      def fix_by_grid
            @games = Game.all
          respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @fixtures }
          end
        end
    
    # This function imports matches from CSV file and also updates the match id based on what was selected in the view
    def import   
      row_id = Fixture.import(params[:file])
      @g = (params[:game])
      game = @g["game_id"]
      Rails.logger.debug("game in controller: #{game.inspect}")
        Fixture.updaterow(row_id, game)
      redirect_to fixtures_path, notice: "Matches imported."
    end

    # GET /fixtures/1
    # GET /fixtures/1.json
    def show
      @fixture = Fixture.find(params[:id])
 
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @expense }
        format.json { render json: @fixture }
      end
    end

    # GET /fixtures/new
    # GET /fixtures/new.json
   

    # GET /fixtures/1/edit
    def edit
      @fixture = Fixture.find(params[:id])
    end

    # POST /fixtures
    # POST /fixtures.json
    def create
      @fixture = @game.fixtures.create(params[:fixture])

      if  @fixture.valid?
          @fixture.save
          redirect_to game_path(@game)
    else
        @fixture.errors
        flash[:error] = @fixture.errors.full_messages
      
      end
    end

    # PUT /fixtures/1
    # PUT /fixtures/1.json
    def update
      @fixture = Fixture.find(params[:id])

      respond_to do |format|
        if @fixture.update_attributes(params[:fixture])
          format.html { redirect_to @fixture, notice: 'Fixture was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @fixture.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /fixtures/1
    # DELETE /fixtures/1.json
    def destroy
      @game = Game.find(params[:game_id])
        @fixture = @game.fixtures.find(params[:id])
        @fixture.destroy
        redirect_to game_path(@game)
  end
  
  def calc_user 
    @fixture = Fixture.find(params[:fixture_id])

  # FIRST CALCULATE ACTUAL RESULT GAP - Update the specified fixture record with the result of Home - Away
      
    if @fixture.update_attributes(:fixresultgap => @fixture.matchhomescore-@fixture.matchawayscore)
      else
    end
    
  # SECOND - CORRECT RESULT CALC - Check above is + - or a draw, then compare to user prediction, 1 point if right

    if @fixture.fixresultgap > 0
      frg = "postive"
    elsif @fixture.fixresultgap == 0
      frg = "draw"
    else 
      frg = "negative"
    end
  
    @pids = params[:predict_ids]
    x = @pids.size-1
       
       while x >= 0
         p = Predict.find(@pids[x])
         p.update_attributes(:val_right_result => p.homescore-p.awayscore)
         
          if p.val_right_result > 0
             ufrg = "postive"
           elsif p.val_right_result == 0
             ufrg = "draw"
           else 
             ufrg = "negative"
         end
         
          if frg == ufrg
            p.update_attributes(:right_result => 1)
            p.update_attributes(:exact_result => 0)
            
            p.update_attributes(:val_exact_result => @fixture.fixresultgap-p.val_right_result)
                if p.val_exact_result == 0 
                    p.update_attributes(:exact_result => 2)
                  else
                end
 
  # THIRD - EXACT HOME OR AWAY SCORE - Update each user.predict record with the value of actual.away- user.away, etc, part of about loop through records    
  # as part of this check, if value match user can be awarded the 'exact home/ away score' point
  
          if @fixture.matchhomescore-p.homescore > 0      
            p.update_attributes(:val_closest_to_home => @fixture.matchhomescore-p.homescore, :closest_to_home => 0)
          else 
            p.update_attributes(:val_closest_to_home => 0-(@fixture.matchhomescore-p.homescore), :closest_to_home => 0)
          end
              if p.val_closest_to_home == 0 
                 p.update_attributes(:exact_home_score => 1)
              else
                 p.update_attributes(:exact_home_score => 0)
              end
            
          if @fixture.matchawayscore-p.awayscore > 0      
            p.update_attributes(:val_closest_to_away => @fixture.matchawayscore-p.awayscore, :closest_to_away => 0)
          else 
            p.update_attributes(:val_closest_to_away => 0-(@fixture.matchawayscore-p.awayscore), :closest_to_away => 0)
          end            
              if p.val_closest_to_away == 0 
                 p.update_attributes(:exact_away_score => 1)
              else
                 p.update_attributes(:exact_away_score => 0)
              end
                    
          else
            p.update_attributes(:right_result => 0, :points => 0)
          end 
          
          x += -1
        end
       
 # CALCULATE NEAREST TO HOME SCORE - Get hash of all user predicts with correct result, sort records by the gap between their away score and the actual away score -adjusted for polarity
     predicts = Predict.where(:fixture_id => @fixture.id, :right_result => 1)
         
      @nearest_home = Hash.new
       for predict in predicts
         @nearest_home[predict.id] = predict.val_closest_to_home     
       end

       @nearest_home = @nearest_home.sort_by { |id, val_closest_to_home| val_closest_to_home }
         
       if @nearest_home.size == 1
         Predict.find(@nearest_home[y].first).update_attributes(:closest_to_home => 1)
       
         elsif @nearest_home.size >= 2
           y = 0  
           x = @nearest_home.size-1
       
           while y < x
             if  @nearest_home[y].second < @nearest_home[y+1].second
               Predict.find(@nearest_home[y].first).update_attributes(:closest_to_home => 1)
               Predict.find(@nearest_home[y+1].first).update_attributes(:closest_to_home => 0)
               y = x+1
             elsif @nearest_home[y].second == @nearest_home[y+1].second
               Predict.find(@nearest_home[y].first).update_attributes(:closest_to_home => 1)
               y = y+1
             else
           end
         end
       end
     
  # CALCULATE NEAREST TO AWAY SCORE - Get hash of all user predicts with correct result, sort records by the gap between their away score and the actual away score -adjusted for polarity
           @nearest_away = Hash.new
            for predict in predicts
              @nearest_away[predict.id] = predict.val_closest_to_away     
            end

            @nearest_away = @nearest_away.sort_by { |id, val_closest_to_away| val_closest_to_away }
              
            if @nearest_away.size == 1
              Predict.find(@nearest_away[y].first).update_attributes(:closest_to_away => 1)
            
              elsif @nearest_away.size >= 2
                y = 0  
                x = @nearest_away.size-1
            
                while y < x
                  if  @nearest_away[y].second < @nearest_away[y+1].second
                    Predict.find(@nearest_away[y].first).update_attributes(:closest_to_away => 1)
                    Predict.find(@nearest_away[y+1].first).update_attributes(:closest_to_away => 0)
                    y = x+1
                  elsif @nearest_away[y].second == @nearest_away[y+1].second
                    Predict.find(@nearest_away[y].first).update_attributes(:closest_to_away => 1)
                    y = y+1
                  else
                end
              end
            end
          
              
  # FINAL STEP - Update each predicts record, where user had correct result, with the total points scored by each user
           predicts = Predict.where(:fixture_id => @fixture.id, :right_result => 1)

             for predict in predicts
               predict.update_attributes(:points => predict.closest_to_home + predict.closest_to_away + predict.right_result + predict.exact_home_score + predict.exact_away_score + predict.exact_result)     
             end 
  
    redirect_to fixture_path(@fixture)
  end
  
end