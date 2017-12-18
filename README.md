# Shiny-Exemplar

This exemplar contains the following [Shiny apps](https://shiny.rstudio.com/):
* TODO

## Docker

Initially, I used the rocker/shiny image available on Dockerhub.  However, because I was unable to install additional R packages, I eventually created my own Docker image based on the rocker/shiny image.  The Dockerfile is included in this repository.

* Docker Commands:
  * sudo docker build -t shiny-exemplar .
  * sudo docker run --rm -p 80:3838 -v /home/ubuntu/Shiny-Exemplar/Shiny-Apps/:/srv/shiny-server/ shiny-exemplar
  * Based on the Rocker/Shiny and the following video:  [RStudio Server running on AWS](https://www.youtube.com/watch?v=zJuFpqB01u4)
  * [Rocker/Shiny](https://hub.docker.com/r/rocker/shiny/) - The image that my image is based on.
    * sudo docker run --rm -p 80:3838 -v /home/ubuntu/Shiny-Exemplar/Shiny-Apps/:/srv/shiny-server/ rocker/shiny

* Notes
  * The server has a directory listing of the running Shiny apps (ie http://localhost)
  * Each app is running as a separate URI resource (ie http://localhost/app-name)

This is the command suggested on the dockerhub page:
 docker run --rm -p 3838:3838 \
       -v /home/ubuntu/Adtalem/Analytics-Shiny-Demo/County-Visualization:/srv/shiny-server/ \
       -v /srv/shinylog/:/var/log/shiny-server/ \
       rocker/shiny


## Links
* [Shiny Tutorials](https://shiny.rstudio.com/tutorial/)
  * This page contains both video and written tutorials for Shiny
  * Written Tutorials
    * [Lesson 1 - Structure of a Shiny App](https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/)
    * [Lesson 2 - Build a User Interface](https://shiny.rstudio.com/tutorial/written-tutorial/lesson2/)
    * [Lesson 3 - Add Control Widgets](https://shiny.rstudio.com/tutorial/written-tutorial/lesson3/)
    * [Lesson 4 - Display Reactive Output](https://shiny.rstudio.com/tutorial/written-tutorial/lesson4/)
    * [Lesson 5 - Use R Scripts and Data](https://shiny.rstudio.com/tutorial/written-tutorial/lesson5/)
* [Shiny Articles/Guides](https://shiny.rstudio.com/articles/)
  * [Application Layout Guide](https://shiny.rstudio.com/articles/layout-guide.html)
* [Shiny Dashboard](https://rstudio.github.io/shinydashboard/)
* [Deploying Shiny Apps](https://shiny.rstudio.com/deploy/)
  * [RStudio - Put Shiny Web Apps Online](https://www.rstudio.com/products/shiny/shiny-server/)
* R Markdown
  * [R Markdown Articles](http://rmarkdown.rstudio.com/articles.html)
  * [R Markdown Gallery](http://rmarkdown.rstudio.com/gallery.html)
