
| Working_with_Colors. (Slides for this and other Data Science courses may be found at github
                        | https://github.com/DataScienceSpecialization/courses/. If you care to use them, they must be downloaded as a
                        | zip file and viewed locally. This lesson corresponds to 04_ExploratoryAnalysis/Colors.)

...

|==                                                                                                    |   1%

| This lesson is about using colors in R. It really supplements the lessons on plotting with the base and
| lattice packages which contain functions that are able to take the argument col. We'll discuss ways to set
| this argument more colorfully.

...

|===                                                                                                   |   3%

| Of course, color choice is secondary to your data and how you analyze it, but effectively using colors can
| enhance your plots and presentations, emphasizing the important points you're trying to convey.

...

|====                                                                                                  |   4%

| The motivation for this lesson is that the default color schemes for most plots in R are not optimal.
| Fortunately there have been recent developments to improve the handling and specification of colors in plots
| and graphs. We'll cover some functions in R as well as in external packages that are very handy. If you know
| how to use some of these then you'll have more options when you create your displays.

...

|======                                                                                                |   6%

| We'll begin with a motivating example - a typical R plot using 3 default colors.

...

|========                                                                                              |   7%

| According to the plot, what is color 2?

1: Blue
2: Red
3: Empty black circles
4: Green

Selection: 2

| That's the answer I was looking for.

|=========                                                                                             |   9%

| So these are the first 3 default values. If you were plotting and just specified col=c(1:3) as one of your
| arguments, these are colors you'd get. Maybe you like them, but they might not be the best choice for your
| application.

...

|==========                                                                                            |  10%

| To show you some options, here's a display of two color palettes that come with the grDevices package
| available to you. The left shows you some colors from the function heat.colors. Here low values are
| represented in red and as the values increase the colors move through yellow towards white. This is
| consistent with the physical properties of fire. The right display is from the function topo.colors which
| uses topographical colors ranging from blue (low values) towards brown (higher values).

...

|============                                                                                          |  12%

| So we'll first discuss some functions that the grDevices package offers. The function colors() lists the
| names of 657 predefined colors you can use in any plotting function.  These names are returned as strings.
| Run the R command sample with colors() as its first argument and 10 as its second to give you an idea of the
| choices you have.

> sample(colors(), 10)
[1] "gray37"         "yellowgreen"    "mistyrose2"     "gray38"         "darkgoldenrod2" "seashell2"     
[7] "pink2"          "grey43"         "gray12"         "grey84"        

| That's a job well done!
  
  |==============                                                                                        |  13%

| We see a lot of variety in the colors, some of which are names followed by numbers indicating that there are
| multiple forms of that particular color.

...

|===============                                                                                       |  15%

| So you're free to use any of these 600+ colors listed by the colors function. However, two additional
| functions from grDevices, colorRamp and colorRampPalette, give you more options. Both of these take color
| names as arguments and use them as "palettes", that is, these argument colors are blended in different
| proportions to form new colors.

...

|================                                                                                      |  16%

| The first, colorRamp, takes a palette of colors (the arguments) and returns a function that takes values
| between 0 and 1 as arguments. The 0 and 1 correspond to the extremes of the color palette. Arguments between
| 0 and 1 return blends of these extremes.

...

|==================                                                                                    |  18%

| Let's see what this means. Assign to the variable pal the output of a call to colorRamp with the single
| argument, c("red","blue").

> pal <- colorRamp(c("red","blue"))

| You got it!
  
  |====================                                                                                  |  19%

| We don't see any output, but R has created the function pal which we can call with a single argument between
| 0 and 1. Call pal now with the argument 0.

> pal(0)
[,1] [,2] [,3]
[1,]  255    0    0

| All that practice is paying off!

|=====================                                                                                 |  21%

| We see a 1 by 3 array with 255 as the first entry and 0 in the other 2. This 3 long vector corresponds to
| red, green, blue (RGB) color encoding commonly used in televisions and monitors. In R, 24 bits are used to
| represent colors. Think of these 24 bits as 3 sets of 8 bits, each of which represents an intensity for one
| of the colors red, green, and blue.

...

|======================                                                                                |  22%

| The 255 returned from the pal(0) call corresponds to the largest possible number represented with 8 bits, so
| the vector (255,0,0) contains only red (no green or blue), and moreover, it's the highest possible value of
| red.

...

|========================                                                                              |  24%

| Given that you created pal with the palette containing "red" and "blue", what color do you think will be
| represented by the vector that pal(1) returns? Recall that pal will only take arguments between 0 and 1, so 1
| is the largest argument you can pass it.

1: blue
2: green
3: red
4: yellow

Selection: 1

| You nailed it! Good job!
  
  |==========================                                                                            |  25%

| Check your answer now by calling pal with the argument 1.

> pal(1)
[,1] [,2] [,3]
[1,]    0    0  255

| Nice work!
  
  |===========================                                                                           |  26%

| You see the vector (0,0,255) which represents the highest intensity of blue. What vector do you think the
| call pal(.5) will return?

1: (127.5,0,127.5)
2: (255,255,255)
3: (255,0,255)
4: (0,255,0)

Selection: 1

| Perseverance, that's the answer.

|============================                                                                          |  28%

| The function pal can take more than one argument. It returns one 3-long (or 4-long, but more about this
| later) vector for each argument. To see this in action, call pal with the argument seq(0,1,len=6).

> pal(seq(0,1,len=6))
     [,1] [,2] [,3]
[1,]  255    0    0
[2,]  204    0   51
[3,]  153    0  102
[4,]  102    0  153
[5,]   51    0  204
[6,]    0    0  255

| Keep up the great work!

|==============================                                                                        |  29%

| Six vectors (each of length 3) are returned. The i-th vector is identical to output that would be returned by
| the call pal(i/5) for i=0,...5. We see that the i-th row (for i=1,...6) differs from the (i-1)-st row in the
| following way. Its red entry is 51 = 255/5 points lower and its blue entry is 51 points higher.

...

|================================                                                                      |  31%

| So pal creates colors using the palette we specified when we called colorRamp. In this example none of pal's
| outputs will ever contain green since it wasn't in our initial palette.

...

|=================================                                                                     |  32%

| We'll turn now to colorRampPalette, a function similar to colorRamp. It also takes a palette of colors and
| returns a function. This function, however, takes integer arguments (instead of numbers between 0 and 1) and
| returns a vector of colors each of which is a blend of colors of the original palette.

...

|==================================                                                                    |  34%

| The argument you pass to the returned function specifies the number of colors you want returned. Each element
| of the returned vector is a 24 bit number, represented as 6 hexadecimal characters, which range from 0 to F.
| This set of 6 hex characters represents the intensities of red, green, and blue, 2 characters for each color.

...

|====================================                                                                  |  35%

| To see this better, assign to the variable p1 the output of a call to colorRampPalette with the single
| argument, c("red","blue"). We'll compare it to our experiments using colorRamp.

> p1 <- colorRampPalette(c("red","blue"))

| That's the answer I was looking for.

|======================================                                                                |  37%

| Now call p1 with the argument 2.

> p1(2)
[1] "#FF0000" "#0000FF"

| You are doing so well!
  
  |=======================================                                                               |  38%

| We see a 2-long vector is returned. The first entry FF0000 represents red. The FF is hexadecimal for 255, the same value
| returned by our call pal(0). The second entry 0000FF represents blue, also with intensity 255.

...

|========================================                                                              |  40%

| Now call p1 with the argument 6. Let's see if we get the same result as we did when we called pal with the argument
| seq(0,1,len=6).

> p1(6)
[1] "#FF0000" "#CC0033" "#990066" "#650099" "#3200CC" "#0000FF"

| You are really on a roll!

|==========================================                                                            |  41%

| Now we get the 6-long vector (FF0000, CC0033, 990066, 650099, 3200CC, 0000FF). We see the two ends (FF0000 and 0000FF) are
| consistent with the colors red and blue. How about CC0033? Type 0xcc or 0xCC at the command line to see the decimal equivalent
| of this hex number. You must include the 0 before the x to specify that you're entering a hexadecimal number.
