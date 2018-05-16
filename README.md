# A simple chain based task tracker for the desktop.

## Why do I want such a tool?

Managing my time have always been hard for me, but this kind chain
based tool have helped me a lot, since it helps keep the focus on a
project from start to finish, so maybe it is more a consistency
management tool, than a time management tool.

This tool is good for managing tasks that often repeat, tasks that
don't repeat is better put in a to-do list, but the task 'Do a task
from the to-do list' is an obvious task for this tool.

The principle behind this kind of tool is to split big projects into
smaller daily steps, and make a 'chain link' for each day on a
calendar, then each day the task is done, you put a check mark in the
chain link for that day. The objective is to not leave a weak link
in the chain, but keep it whole by always doing the tasks, so that you
can a check mark in the chain link. This couples a short term goal 'don't
leave a weak link' with the long term goal 'completing the big
project'.

The original version of this principle, uses a calendar and one chain
link per day, but this application make it possible to select any
time interval. 

## Do you want to see a screenshot?

At the upper right in this [screenshot][screenshotlink] you can see a
rectangular shape full of green, red and some blue pixels. This is
the display of the gochains app, under it you can find a drawer full
of task icons, the color of them indicate, if their task is done or still
missing.

## How is this app constructed? 

The basic design idea is to keep it simple, that is why the core of this app
is a simple text based log file, called chains.log, and a little script called
writechainslog.sh

The writechainslog.sh script takes 2 integer parameters, the first is the
type of task and the second is the value. Any task should be assigned
a type number different from any other task. The value number 0 is
special, it means that a new empty chain link get inserted at the
active end of the chain. This should be used to put in tasks at the
start of the working period/day. When a task is done, a value of 1 is
used, but any integer value greater than 0 can be used. The script
then write the date, time, type and value in the tab separated log file and
then builds chains.svg that can be used for display.

For adding new chain links daily todays_tasks.sh, today.rb and
chains.ct, are used to add them at desktop start up. An execution of
todays_tasks.sh are added under the menu System->Preferences->Startup
Applications. The file chains.ct is a crontab file describing when
different chains should be executed.

The ruby scripts log2matrix.rb, log2svg.erb and log2tab.rb is for
reading the log file and converting it to other formats like svg
images, or tab separated text files.

Script log2svg.erb is used to generate the svg file chains.svg, that is the
important file for the display of the chains. In this svg image the
task types are the columns and the rows are previous chain links, so
the chains are hanging from the top to the bottom. New chain links are
put in at the top.

For the display of the chains, I have modified the mate-panel to
detect change to an icon file and then reload and display the icon,
these changes can be used via the Drawer and Custom Launcher Applet.
The patch called 'Updateable Icons' can be found [here][patchlink].

The folders type_icons.d and display_icons.d is used to hold the
icons for the tasks. They change color when the task type value is
changed. Red means task not done jet, since its value is zero. Green means
task done and its value is one. Blue that the value is greater than one.

## Setup your own version of the chains apps.

1. Installed the software using git.

2. Do a 'make install' in the shell. This will make a data folder in $HOME/.gochains-data, copy some programs to
/usr/local/bin, and set GOCHAINSPATH and GOCHAINSDATA in $HOME/.bashrc..

3. For each event type you want, [find][iconsearch] and download a svg image file to the folder
type_icons.d in the new data folder at $HOME/.gochains-data. Rename it <type>_<mnemonic>.svg for example 1_exercise.svg for a exercise task.  

4. In every svg file add the following lines after the <svg .... /> line 

  <defs>
    <linearGradient id="displayColor">
      <stop offset="0" stop-color="black" />
    </linearGradient>
  </defs>

 and also replace every fill="some color" with fill="url(#displayColor)".

 Now when the writechainslog.sh script is used the color in
 stop-color="black" is changed and the result file is placed in the
 folder display_icons.d
 
 5. The chains.ct crontab file where you can put in automatic call to
 writechainslog.sh, I use it to initialize my daily tasks. Just fill
 is as a normal crontab file, but with a call to writechainslog.sh
 <type> 0, meaning at this time a new empty chain link should be added
 the types chain.

6. Now add some data to the chains.log, by executing writechainslog.sh
   a couple of times.  Using types 1-5 with the value of 0. This
   should produce some icons in display_icons.d, go ahead and look at
   with the image viewer 'eom'. These files you can find in the data
   folder at $HOME/.gochains

Next we will setup the user interface in the desktop panel, to get
full functionality, the mate-panel should be updated with code that
make it detect icon change on disk. If you don't use the mate-panel,
feel to investigate how to make your favorite desktop do the same.

7. Add a new drawer to a panel where you want the app. Then in the
Drawers properties, set the icon to be display_icons.d/chains.svg,
this will now act as an overview display.

8. To the Drawer add a 'Custom Application Launcher' and in the
 properties add a call to writechainslog.sh with a type <type> and the
 value 1 also set the icon to display_icons.d/<type>.svg

9. Repeat step 8 for all your tasks, and you are all done.
 
---
[patchlink]:https://github.com/Isomorph70/mate-panel/tree/updateable-icons
[iconsearch]:https://www.shareicon.net/
[screenshotlink]:https://ipfs.io/ipfs/QmPigGYCZ8nitKq1cpGi1Tw1Bx5V1566zP571swRmiSQh4
