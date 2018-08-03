#
# This script is designed to parse the output of the following command:
#   find . -type f | xargs wc -l
#

library(stringr)

setwd('~/Github-Public/Shiny-Exemplar/Shiny-Apps/Software-Analysis/')
log <- str_trim(readLines('files.log'))

# Remove 3rd-party and legacy libraries from the log file
log <- log[!str_detect(log, "\\/3rd-party\\/") & !str_detect(log, "\\/legacy\\/")]

# Remove assets, libs, resources and 'Pods' from the log file
log <- log[!str_detect(log, "assets\\/") & !str_detect(log, "libs\\/") & !str_detect(log, "resources\\/") & !str_detect(log, "Pods\\/")]

# Remove Deliverfile Gymfile and Podfile from the log file
log <- log[!str_detect(log, "\\/(Deliverfile|Gymfile|Podfile)")]

x <- data.frame(Lines = as.integer(str_extract(log, "[0-9][0-9]*")),
                Repository = str_sub(str_extract(log, "\\./[a-zA-Z0-9\\-\\_\\ ]+/"), start = 3, end = -2),
                Filename = str_sub(sapply(str_extract_all(log, "\\/[a-zA-Z0-9\\-\\_\\+\\ ]+(\\.[a-zA-Z]+)?"), function(x) x[length(x)]), start = 2))

# Extract and add common filetypes (when the filetype is normally blank, eg., Makefile)
x$Filetype <- str_sub(str_extract(x$Filename, "\\.[a-zA-Z]+"), start = 2)
sum(is.na(x$Filetype))
x$Filetype[x$Filename == 'Dockerfile'] <- 'Dockerfile'
x$Filetype[x$Filename == 'gradlew'] <- 'Gradle'
x$Filetype[x$Filename == 'known_hosts'] <- 'txt'
x$Filetype[x$Filename == 'LICENSE'] <- 'txt'
x$Filetype[x$Filename == 'Makefile'] <- 'Makefile'
x$Filetype[x$Filename == 'README'] <- 'txt'
x$Filetype[is.na(x$Filetype)] <- 'Unknown'
sum(is.na(x$Filetype))

x <- x[ , c(2:4, 1)]
head(x)
# x[is.na(x$Filetype), ]
# table(x$Filetype)

write.csv(x, file = 'files.csv', row.names = FALSE)
