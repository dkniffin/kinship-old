Things to Document
==================
- Birth [Event]
- Death [Event]
- Marriage [Event]
- Residence [Period]
- Burial [Event]
- Cremation [Event]
- Occupation [Period]
- Graduation [Event]
- Family Reunion [Event]
- Divorce [Event]
- Adoption [Event]
- Change of residence [Event]
- Retirement [Period]
- Promotion [Event]
- Census [Event]
- Religion [Fact]
- Title [Fact]
- SSN [Fact]
- Military Enlistment [Event]
- Battle
- Military Discharge [Event]
- Immigration [Event]
- Emmigration [Event]
- Naturalization [Event]

- Custom Period [Period]
- Custom Event [Event]
- Custom Fact [Fact]

Objects and Inheritence
=======================
TimelineObject - Anything that would fit in a timeline
Event - Something that happened at a single time, relating directly to a person or people in the genealogy
Period - A start and (optional) end time. No end time indicates it's still ongoing. Again, related directly to a person or people in the genealogy
ContextEvent - A single time, but not directly related to the genealogy
ContextPeriod - A start and end time "                         "
Fact - An attribute of a person
Source - Something that provides supporting evidence
```
Event < TimelineObject
   has_many Source
   has_one Place # Optional
PeriodEvent < TimelineObject
   has_many Source
   has_one Place # Optional
ContextEvent < TimelineObject
   has_many Source
ContextPeriod < TimelineObject
   has_many Source
Fact
   has_many Source
   has_one Place # Optional
```
------------------------------------------------------
Scratch all that above...

For events, use STI. Most of the fields overlap.

LifeEvent
  date # start date in some cases
  end_date # optional
------------------------------------------------------

For Sources, use polymorphic references. So, we'd have:

class LifeEvent
  has_many :sources

# Might need AS::Concern
# http://api.rubyonrails.org/classes/ActiveSupport/Concern.html
module Source
  belongs_to :lifeevent, polymorphic: true, as: :source


class Census
  include Source