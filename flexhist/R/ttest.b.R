
# This file is a generated template, your changes will not be overwritten

ttestClass <- if (requireNamespace('jmvcore', quietly=TRUE)) {
    R6::R6Class(
    "ttestClass",
    inherit = ttestBase,
        private = list(
            .run = function() {
              
              if (length(self$options$dep) == 0 || length(self$options$group) == 0) {
                return()
              }
              
                formula <- jmvcore::constructFormula(self$options$dep, self$options$group)
                formula <- as.formula(formula)

                results <- t.test(formula, self$data)

                self$results$text$setContent(results)
                
                table <- self$results$ttest
                
                table$setRow(rowNo=1, values=list(
                  var=self$options$dep,
                  t=results$statistic,
                  df=results$parameter,
                  p=results$p.value
                ))
                
                plotData <- data.frame(
                  dep = self$data[[ self$options$dep ]],
                  grp = self$data[[ self$options$group ]]
                )
                
                image <- self$results$plot
                image$setState(plotData)
          },
            .plot=function(image, ...) {  # <-- the plot function
              plotData <- image$state
              
              breaks = pretty(range(plotData$dep),
                              n = nclass.Sturges(plotData$dep),
                              min.n = 1)
              
              plot <- ggplot(plotData, aes(x=dep)) +
                geom_histogram(colour="black", fill="white", breaks=breaks) +
                facet_wrap(~grp) +
                labs(title=self$options$dep)
              print(plot)
              TRUE
            })
        )
}
