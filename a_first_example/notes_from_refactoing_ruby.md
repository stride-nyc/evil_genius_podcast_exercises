# Notes from Refactoring: Ruby edition

## Problem Statement

> In this case we have a couple of changes that the users would like to make. First they want a statement printed in HTML so that the statement can be Web enabled and more buzzword compliant. Consider the impact this change would have. As you look at the code you can see that it is impossible to reuse any of the behavior of the current statement method for an HTML statement. Your only recourse is to write a whole new method that duplicates much of the behavior of statement. Now, of course, this is not too onerous. You can just copy the statement method and make whatever changes you need.


> But what happens when the charging rules change? You have to fix both statement and html_statement and ensure the fixes are consistent. The problem with copying and pasting code comes when you have to change it later. If you are writing a program that you don’t expect to change, then cut and paste is fine. If the program is long lived and likely to change, then cut and paste is a menace.

> This brings me to a second change. The users want to make changes to the way they classify movies, but they haven’t yet decided on the change they are going to make. They have a number of changes in mind. These changes will affect both the way renters are charged for movies and the way that frequent renter points are calculated. As an experienced developer you are sure that whatever scheme the users come up with, the only guarantee you’re going to have is that they will change it again within six months.

> The statement method is where the changes have to be made to deal with changes in classification and charging rules. If, however, we copy the statement to an HTML statement, we need to ensure that any changes are completely consistent. Furthermore, as the rules grow in complexity it’s going to be harder to figure out where to make the changes and harder to make them without making a mistake.

> You may be tempted to make the fewest possible changes to the program; after all, it works fine. Remember the old engineering adage: “if it ain’t broke, don’t fix it.” The program may not be broken, but it does hurt. It is making your life more difficult because you find it hard to make the changes your users want. This is where refactoring comes in.

Fields, Jay. Refactoring: Ruby Edition (Addison-Wesley Professional Ruby Series)

To summarize: This would be fine if it were never going to change. The change requested already suggest that other changes are coming. Already we see that the need for an `HTML` version of statement means that code needs to be duplicated and we notice how coupled the `statement` method is to `Movie` and `Rental` classes.