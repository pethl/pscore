// --------------------------------------------------------------------------------------
// Fixture - ObjC Model Implementation based on Ruby on Rails model
// generated by XcodeTemplate helper (c) jTribe Holdings Pty Ltd 2011 - www.jtribe.com.au
// --------------------------------------------------------------------------------------

#import "Fixture.h"

@implementation Fixture

@synthesize awayteam = _awayteam;
@synthesize content = _content;
@synthesize created_at = _created_at;
@synthesize game_id;
@synthesize hometeam = _hometeam;
@synthesize fixture_id;
@synthesize matchdate = _matchdate;
@synthesize updated_at = _updated_at;


// designated initializer

-(id)initWithDictionary:(NSDictionary*)dictionary
{
    if ((self = [super init]) == nil) { return nil; }

    // initialise ivars

    _awayteam = nil;
    _content = nil;
    _created_at = nil;
    game_id = 0;
    _hometeam = nil;
    fixture_id = 0;
    _matchdate = nil;
    _updated_at = nil;

    // initialise object from dictionary attributes from dictionary

    if (dictionary)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        if ([dictionary objectForKey:@"awayteam"])
        {
            self.awayteam = [dictionary objectForKey:@"awayteam"];
        }

        if ([dictionary objectForKey:@"content"])
        {
            self.content = [dictionary objectForKey:@"content"];
        }

        if ([dictionary objectForKey:@"created_at"])
        {
            self.created_at = [dateFormatter dateFromString:[dictionary objectForKey:@"created_at"]];
        }

        if ([dictionary objectForKey:@"game_id"])
        {
            self.game_id = [[dictionary objectForKey:@"game_id"] intValue];
        }

        if ([dictionary objectForKey:@"hometeam"])
        {
            self.hometeam = [dictionary objectForKey:@"hometeam"];
        }

        if ([dictionary objectForKey:@"fixture_id"])
        {
            self.fixture_id = [[dictionary objectForKey:@"fixture_id"] intValue];
        }

        if ([dictionary objectForKey:@"matchdate"])
        {
            self.matchdate = [dateFormatter dateFromString:[dictionary objectForKey:@"matchdate"]];
        }

        if ([dictionary objectForKey:@"updated_at"])
        {
            self.updated_at = [dateFormatter dateFromString:[dictionary objectForKey:@"updated_at"]];
        }


        [dateFormatter release];

    } // end if dictionary was passed in
    return self;
} // end initWithDictionary


#pragma mark -
#pragma mark Memory

- (id)init
{
    return [self initWithDictionary:nil];
}

- (void)dealloc
{

    // synthesized setter takes care of release
    self.awayteam = nil;
    self.content = nil;
    self.created_at = nil;
    self.hometeam = nil;
    self.matchdate = nil;
    self.updated_at = nil;
    [super dealloc];
}

@end
