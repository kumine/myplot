% modified from ggsave

\name{myplot}
\alias{myplot}
\title{recording all R call as a myplot object, and then passing to plotsave saving graphic}
\usage{
myplot(...)
}
\arguments{
\item{...}{all R call to recording}
}
\description{
\code{myplot()} use \code{match.call} to record R call.using \\{\\} is  more convenient, see examples.
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

