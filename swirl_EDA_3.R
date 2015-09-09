
| Graphics_Devices_in_R. (Slides for this and other Data Science courses may be found at github
                          | https://github.com/DataScienceSpecialization/courses/. If you care to use them, they must be
                          | downloaded as a zip file and viewed locally. This lesson corresponds to
                          | 04_ExploratoryAnalysis/Graphics_Devices_in_R.)

...

|===                                                                                           |   3%

| As the title suggests, this will be a short lesson introducing you to graphics devices in R. So, what
| IS a graphics device?

...

|======                                                                                        |   6%

| Would you believe that it is something where you can make a plot appear, either a screen device, such
| as a window on your computer, OR a file device?

...

|=========                                                                                     |   9%

| There are several different kinds of file devices with particular characteristics and hence uses.
| These include PDF, PNG, JPEG, SVG, and TIFF. We'll talk more about these later.

...

|===========                                                                                   |  12%

| To be clear, when you make a plot in R, it has to be "sent" to a specific graphics device. Usually
| this is the screen (the default device), especially when you're doing exploratory work. You'll send
| your plots to files when you're ready to publish a report, make a presentation, or send info to
| colleagues.

...

|==============                                                                                |  15%

| How you access your screen device depends on what computer system you're using. On a Mac the screen
| device is launched with the call quartz(), on Windows you use the call windows(), and on Unix/Linux
| x11().  On a given platform (Mac, Windows, Unix/Linux) there is only one screen device, and obviously
| not all graphics devices are available on all platforms (i.e. you cannot launch windows() on a Mac).

...

|=================                                                                             |  18%

| Run the R command ?Devices to see what graphics devices are available on your system.

> ?Devices

| You got it right!

|====================                                                                          |  21%

| R Documentation shows you what's available.

|=======================                                                                       |  24%

| There are two basic approaches to plotting. The first, plotting to the screen, is the most common.
| It's simple - you call a plotting function like plot, xyplot, or qplot (which you call depends on the
| plotting system you favor, but that's another lesson), so that the plot appears on the screen. Then
| you annotate (add to) the plot if necessary.

...

|==========================                                                                    |  27%

| As an example, run the R command with with 2 arguments. The first is a dataset, faithful, which comes
| with R, and the second is a call to the base plotting function plot. Your call to plot should have
| two arguments, eruptions and waiting. Try this now to see what happens.

