# wc in less than 1000 characters without a single if statement in D

## The Introduction
After reading "Beating C With 80 Lines Of Haskell: Wc"
https://chrispenner.ca/posts/wc found on hackernews.
I thought D could do better.

## The Program
So I wrote a wc in D.
I consists of one file, has 46 lines and 906 characters.
Sure, it is using D's awesome standard library phobos.
But then why wouldn't it, its awesome and it comes with every D compiler.
The program itself does not contain a single if statement.
Talking about imperative programming languages;
the Haskell wc implementation has several if statements.
The D program, apart from the main function, contains three tiny functions.
I could have easily put all the functionally in one range chain,
but then it properly would have exceed 80 chars per line.
And that's a major code-smell.

The Performance:
Is the D wc faster than the coreutils wc?
No, but it took my 15 minutes to write mine (I had to search for walkLength,
because I forgot its name).

file      | lines | bytes | coreutils         | haskell             | D                   |
----------|-------|-------|-------------------|---------------------|---------------------|
app.d     | 46    | 906   | 3.5 ms +- 1.9 ms  | 39.6 ms +- 7.8 ms   | 8.8 ms +- 2.0 ms    |
big.txt   | 862   | 64k   | 4.7 ms +- 2.0 ms  | 39.6 ms +- 7.8 ms   | 9.3 ms +- 1.9 ms    |
vbig.txt  | 1.7M  | 96M   | 658.6ms +- 24.5ms | 226.4 ms +- 29.5 ms | 716.2 ms +- 30.8 ms |
vbig2.txt | 12.1M | 671M  | 4.4 s +- 0.058 s  | 1.1 s +- 0.039 s    | 4.8 s +- 0.051 s    |

memory:

file      | coreutils | haskell | D     |
----------|-----------|---------|-------|
app.d     | 2052K     | 7228K   | 7588K |
big.txt   | 2112K     | 7512K   | 7556K |
vbig.txt  | 2288K     | 42620K  | 7772K |
vbig2.txt | 2360K     | 50860K  | 7692K |

Is the Haskell wc faster?
For big files, absolutely, but then it is using threads.
For small files, gnu's coreutils still beats the competition.
For very big files the difference between the coreutils and the D program is
reduced quite a bit to ~10%.
At this stage its is very likely IO bound, and its fast enough anyway.

## The conclusion
I'll not claim that one language is faster than another.
If you spend crazy time on a micro-benchmark and optimizing you are going to
beat the competition.
That's not real life, who cares?

__But I'll claim, that functional programming in D gives functional programming
in Haskell a run for its money.__


### About Kaleidic Associates
We are a boutique consultancy that advises a small number of hedge fund clients.
We are not accepting new clients currently, but if you are interested in working
either remotely or locally in London or Hong Kong, and if you are a talented
hacker with a moral compass who aspires to excellence then feel free to drop me
a line: laeeth at kaleidic.io

We work with our partner Symmetry Investments, and some background on the firm
can be found here:

http://symmetryinvestments.com/about-us/
