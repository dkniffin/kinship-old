- Timeline
	- timeline of objects, displayed as a vertical timeline, with basic info on
the left, details on the right, and an icon in the middle
- Auto-import of sources
	- Give a URL, body of text, or image, and automatically extract data
	from it. Then, prompt user for confirmation, before automatically adding
	it to certain objects in the database.
	- Something like MyCookbook's import
- Context Events
	- In addition to family-specific events, have historical events that can be added, to give additional context.
	- For example, for relatives in WW2, you might have "Start of WW2", and "D-Day" that can be added.
	- These should be global settings that can be toggled. So, all relatives alive during the right time period would have these events displayed on their timeline
	- Context events should be displayed differently on the timeline, to indicate that they are context events. Use CSS classes to power this. Then in CSS, perhaps they're a different color, or use a different icon.
- "Auto-generated" bio pages
	- Based on the data, create something similar to a wikipedia page for each person in the DB.
	- Some elements on the page
		- Portrait
		- Stats box
		- Template blurb ("<person> (<birth>-<death>) blah blah blah")
			- Use some standard template language. erb? liquid?
	- In order to make this work well, there would need to be a way to add detailed information about people. For example, you could add a manually-created body of text about the person. Obituary text would be a good source for some of this.
