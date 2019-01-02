# Course Template

The purpose of this template is to define an easy way to build a course website in Rmarkdown building the functionality of R Studio to build static websites. This is not perfect, but it provides a nice template for further customisation as desired. This template is inspired by [Steven V Miller](svmiller.com).

# Starting

Go ahead and change the details within the `_site.yml` file. These data include your name, the course name, information regarding your social media/ github, physical address and google analytics if desired. Please do not delete any of the main information outside of the navigation bar; just leave information blank if it is not needed. 

# Navigation Bar

Right now the basic structure is for 

1. Syllabus - where you can put your syllabus
1. Lectures - Where you put your slides/ code
1. Exercises - where you can put exercises
1. Resources - Where you can include links to other resources or the book
1. Home - where you can direct the students back to your main website

You can add/ delete these to your liking.

# Subfolders

There are some limitations regarding Rmarkdown. If you want to add additional nested pages you won't get the navigation bar, so that is a little annoying, but there are work arounds. The easiest option is just to keep adding documents in the main directory here.

# Build the site

You can use R Studio to build the site and then enable github pages to host the site. 

Enjoy!

# Credits
This website template is largely inspired by Steve Miller's (@svmiller) jekyll website with some modifications/ translations. 
