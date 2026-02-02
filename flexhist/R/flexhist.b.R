# This file is a generated template, your changes will not be overwritten

flexhistClass <- if (requireNamespace('jmvcore', quietly = TRUE)) {
    R6::R6Class(
        "flexhistClass",
        inherit = flexhistBase,
        private = list(
            .run = function() {
                if (length(self$options$dep) == 0) {
                    return()
                }

                plotData <- data.frame(
                    dep = self$data[[self$options$dep]]
                )
                image <- self$results$plot
                image$setState(plotData)
            },
            .plot = function(image, ...) {
                if (length(self$options$dep) == 0) {
                    return()
                }
                # <-- the plot function
                plotData <- image$state

                # ggplot default breaks
                if (self$options$binWidthType == "default") {
                    plot <- ggplot(plotData, aes(x = dep)) +
                        geom_histogram(
                            colour = "black",
                            fill = "white"
                        )
                }

                # sturges breaks
                if (self$options$binWidthType == "sturges") {
                    sturges = pretty(
                        range(plotData$dep),
                        n = nclass.Sturges(plotData$dep),
                        min.n = 1
                    )

                    plot <- ggplot(plotData, aes(x = dep)) +
                        geom_histogram(
                            colour = "black",
                            fill = "white",
                            breaks = sturges
                        )
                }

                # manual breaks
                if (self$options$binWidthType == "manual") {
                    max_val <- max(plotData$dep, na.rm = TRUE)
                    breaks <- seq(
                        from = self$options$binLowerLimit,
                        to = ceiling(max_val / self$options$binWidth) *
                            self$options$binWidth,
                        by = self$options$binWidth
                    )

                    plot <- ggplot(plotData, aes(x = dep)) +
                        geom_histogram(
                            colour = "black",
                            fill = "white",
                            breaks = breaks
                        )
                }

                print(plot)
                TRUE
            }
        )
    )
}
