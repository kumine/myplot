# myplot package: Saving all base R graphics like ggsave


### Chinese help please [see](https://www.jianshu.com/p/e2219188f14e)


## 1.install

myplot package is not available in CRAN. you can install it in github using following code.


```r
library(devtools)
install_github("kumine/myplot")
```

## 2.usage

- if we want to save a graphic with png and pdf format, we will do it as follow. It is **repetitive**. What's worse. We must modify two place if any errors. How crazy!

```r
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
```

- As we all known, **ggsave** in package *ggplot2* saving a plot  is a convenient (as follow). 


```r
library(ggplot2)
ggplot(mtcars, aes(mpg, wt)) + geom_point()

ggsave("mtcars.pdf")
ggsave("mtcars.png")

ggsave("mtcars.pdf", width = 4, height = 4)
ggsave("mtcars.pdf", width = 20, height = 20, units = "cm")

```

- Whether can we save base R graphics like **ggsave**? The answer is *YES*. Using **myplot** package, We can save all base R graphic like ggsave. myplot package have two functions:

   - **myplot**:  use *match.call* to record all R call as a myplot object, and then passing to *plotsave* saving graphic.
   - **plotsave**: Save a myplot class plot. it is modified from **ggsave** and has all features of **ggsave**.

- We can use **myplot** as follow. But it seems some inconvenient

```r
library(myplot)
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
```

- **{}** make **myplot** much convenient. All R code can be written in **{}** as usual.


```r
library(myplot)
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

```




