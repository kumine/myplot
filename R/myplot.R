# myplot=function(...) {
#   UseMethod("myplot")
# }

#
myplot=function(...){
  if (missing(...)) return(invisible(NULL))
  dots=match.call(expand.dots = FALSE)$...
  structure(dots, class = "myplot")
}

# myplot.default=function(...){
#   if (missing(...)) return(invisible(NULL))
#   dots=match.call(expand.dots = FALSE)$...
#   structure(dots, class = "myplot")
# }

# print.myplot=function(plot, environment = parent.frame()){
#   for(i in 1:length(plot)){eval(plot[[i]], envir=environment)}
# }


##modified from ggsave

plotsave=function(plot,file=NULL,
                device = default_device(file), 
                path = NULL, scale = 1, 
                width = par("din")[1], 
                height = par("din")[2], 
                units = c("in", "cm", "mm"),
                dpi = 300, limitsize = TRUE, 
                environment = parent.frame(),
                ...
){
  if (!class(plot)=="myplot") stop("plot should be a myplot list")
  
  if(is.null(file)){
    for(i in 1:length(plot)){eval(plot[[i]], envir=environment)}
  }else{
    eps <- ps <- function(..., width, height) grDevices::postscript(..., 
                                                                    width = width, height = height, onefile = FALSE, horizontal = FALSE, 
                                                                    paper = "special")
    tex <- function(..., width, height) grDevices::pictex(..., 
                                                          width = width, height = height)
    pdf <- function(..., version = "1.4") grDevices::pdf(..., 
                                                         version = version)
    svg <- function(...) grDevices::svg(...)
    wmf <- function(..., width, height) grDevices::win.metafile(..., 
                                                                width = width, height = height)
    emf <- function(..., width, height) grDevices::win.metafile(..., 
                                                                width = width, height = height)
    png <- function(..., width, height) grDevices::png(..., width = width, 
                                                       height = height, res = dpi, units = "in")
    jpg <- jpeg <- function(..., width, height) grDevices::jpeg(..., 
                                                                width = width, height = height, res = dpi, units = "in")
    bmp <- function(..., width, height) grDevices::bmp(..., width = width, 
                                                       height = height, res = dpi, units = "in")
    tiff <- function(..., width, height) grDevices::tiff(..., 
                                                         width = width, height = height, res = dpi, units = "in")
    
    default_device <- function(file) {
      pieces <- strsplit(file, "\\.")[[1]]
      ext <- tolower(pieces[length(pieces)])
      match.fun(ext)
    }
    units <- match.arg(units)
    convert_to_inches <- function(x, units) {
      x <- switch(units, `in` = x, cm = x/2.54, mm = x/2.54/10)
    }
    convert_from_inches <- function(x, units) {
      x <- switch(units, `in` = x, cm = x * 2.54, mm = x * 
                    2.54 * 10)
    }
    if (!missing(width)) {
      width <- convert_to_inches(width, units)
    }
    if (!missing(height)) {
      height <- convert_to_inches(height, units)
    }
    if (missing(width) || missing(height)) {
      message("Saving ", 
              prettyNum(convert_from_inches(width * scale, units), digits = 3),
              " x ", prettyNum(convert_from_inches(height * scale, units), digits = 3), " ", units, " image")
    }
    width <- width * scale
    height <- height * scale
    if (limitsize && (width >= 50 || height >= 50)) {
      stop("Dimensions exceed 50 inches (height and width are specified in inches/cm/mm, not pixels).", 
           " If you are sure you want these dimensions, use 'limitsize=FALSE'.")
    }
    if (!is.null(path)) {
      file <- file.path(path, file)
    }
    device(file = file, width = width, height = height, ...)
    on.exit(capture.output(dev.off()))
   # print(plot)
    for(i in 1:length(plot)){eval(plot[[i]], envir=environment)}
  }
  invisible()
}

