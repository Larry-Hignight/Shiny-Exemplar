library(lubridate)
library(stringr)

setwd('~/Github-Public/Shiny-Exemplar/Shiny-Apps/Software-Analysis/')
commits <- read.csv('commits.csv', header = TRUE)
commits$Month <- month(commits$Date)
files <- read.csv('files.csv', header = TRUE)
files$Filetype <- as.character(files$Filetype)


## Commit Analysis ----
table(commits$User)
table(commits$Repository, commits$User)

table(commits$User, month(commits$Month, label = TRUE))
table(commits$Repository, month(commits$Month, label = TRUE))


## Files Analysis ----
table(files$Repository)
table(files$Filetype)
table(files$Filetype, files$Repository)


# Narrowing down the number of files and filetypes
keep <- c('bat','cpp','css','d','gradle','h','hpp','html','jar','java','json','kt','markdown','md','sh','sql','xml','yml')
files2 <- files[files$Filetype %in% keep, ]
table(files2$Repository, files2$Filetype)

