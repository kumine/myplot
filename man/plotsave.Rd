% modified from ggsave

\name{plotsave}
\alias{plotsave}
\title{Save a myplot class with sensible defaults}
\usage{
plotsave(plot,file=NULL,
                device = default_device(file), 
                path = NULL, scale = 1, 
                width = par("din")[1], 
                height = par("din")[2], 
                units = c("in", "cm", "mm"),
                dpi = 300, limitsize = TRUE, 
                environment = parent.frame(),
                ...)
}
\arguments{
\item{plot}{A myplot object to save}

\item{file}{File name to create on disk.plot current window if NULL}

\item{device}{Device to use (function or any of the recognized extensions,
e.g. \code{"pdf"}). By default, extracted from filename extension.
\code{plotsave} currently recognises eps/ps, tex (pictex), pdf, jpeg, tiff,
png, bmp, svg and wmf (windows only).}

\item{path}{Path to save plot to (combined with filename).}

\item{scale}{Multiplicative scaling factor.}

\item{width, height}{Plot dimensions, defaults to size of current graphics
device.}

\item{units}{Units for width and height when specified explicitly (in, cm,
or mm)}

\item{dpi}{Resolution used for raster outputs.}

\item{limitsize}{When \code{TRUE} (the default), \code{plotsave} will not
save images larger than 50x50 inches, to prevent the common error of
specifying dimensions in pixels.}

\item{...}{Other arguments passed on to graphics device}
}
\description{
\code{plotsave()} is a convenient function for saving a plot. It also guesses the type of graphics device from the extension.
}
\examples{
\dontrun{
set.seed(1)
x=rnorm(100)
y=x*5+rnorm(100)


png(file="test1.png",units = "cm",width = 15, height = 15, units = "cm",res=300)
plot(x,y,pch=20)
lm=lm(y~x)
abline(lm,col="red")
points(x[1:5],y[1:5],col="blue",cex=1.5,pch=20)
dev.off()


pdf(file="test1.pdf")
plot(x,y,pch=20)
lm=lm(y~x)
abline(lm,col="red")
points(x[1:5],y[1:5],col="blue",cex=1.5,pch=20)
dev.off()

# myplot 1

p=myplot(set.seed(1),
         x=rnorm(100),
         y=x*5+rnorm(100),
         plot(x,y,pch=20),
         lm=lm(y~x),
         abline(lm,col="red"),
         points(x[1:5],y[1:5],col="blue",cex=1.5,pch=20))
plotsave(p)
plotsave(p,file="test2.png",width = 15, height = 15, units = "cm")
plotsave(p,file="test2.pdf",width = 150, height = 150, units = "mm")


# myplot 2

#using {}  more convenient

rm(list=ls())
set.seed(1)
x=rnorm(100)
y=x*5+rnorm(100)

p=myplot({
  plot(x,y,pch=20)
  lm=lm(y~x)
  abline(lm,col="red")
  points(x[1:5],y[1:5],col="blue",cex=1.5,pch=20)
})

plotsave(p)
plotsave(p,file="test3.png",width = 15, height = 15, units = "cm")
plotsave(p,file="test3.pdf",width = 150, height = 150, units = "mm")

}
}

