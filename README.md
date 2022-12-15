# AgrigateOne Vessel Assement!
---
- Intro block

## Overview
---

- This is a description block

```
.
├── data/
├── dbt_project.yml
├── lightdash-dockerfile
├── lightdash-entrypoint.sh
└── models
    └── profiles.yml
    └── profiles.yml
```

##Questions and Answers
---

1. How many distinct ships do we have information about?

- `There are 3400 distinct vessel`

2. Currently we have information on a large number of container ships. How many
of these ships would be classified as ULCV?

- `There are 3400 distinct vessels`

## Question 3: After collecting information on ports that exist around the world
(vessel_ports) you noticed that something went wrong and bad information
was placed in the code column. Using another column available in the table,
return a list of rows where the majority of codes have been incorrectly filled.


- There are 3400 distinct vessels

### Question 4: What is the ratio of ports that ships have interacted with within the tracked
events versus the number of ports identified to exist?

- There are 3400 distinct vessels

### Question 5: A client wants to know the average time interval between the ship departing
from the SINES port and docking at the RODMAN port.

- There are 3400 distinct vessels

### Question 6: A client wants a distinct list of all the routes the ship APL GULF EXPRESS has
completed in the past. Generate a table with two columns labelled “Origin Port”
and “Destination Port” of all the unique port to port routes this ship has
completed.

- There are 3400 distinct vessels

### Question 7: Generate a table that breaks down the events a vessel undergoes between two
ports. This should include the following:
- mmsi: A unique id to identify the ship which can be linked back to the
ship info table if more information is needed.
- origin_port: The port the ship started at.
- origin_port_time_stamp: The time the ship departed the port.
- destination_port: The port the ship arrived at.
- destination_port_time_stamp: The time the ship arrived at the
destination port.

