Things to Document
==================
- Birth [Event]
  - child_id
  - father_id
  - mother_id
  - date
  - place
- Death [Event]
  - person_id
  - date
  - place
  - cause
- Marriage [Event]
  - spouse_1_id
  - spouse_2_id
- Divorce [Event]
  - do we need this? It could be an end date on the marriage
- Residence [Period]
- Burial [Event]
- Cremation [Event]
- Occupation [Period]
- Graduation [Event]
- Family Reunion [Event]
- Adoption [Event]
- Change of residence [Event]
- Retirement [Period]
- Promotion [Event]
- Census [Event]
- Military Enlistment [Period]
- Immigration [Event]
- Emmigration [Event]
- Naturalization [Event]

- Religion [Fact]
- Title [Fact]
- SSN [Fact]

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
