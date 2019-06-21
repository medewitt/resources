# Usually, only these lines need changing
RDIR= .
DOCS= ./docs


# List files for dependencies
DOCS_RFILES := $(wildcard $(DOCS)/*.html)

# Indicator files to show R file has run
DOCS_OUT_FILES:= $(DOCS_RFILES:.Rmd=.html)

# Run everything
all: $(DOCS_OUT_FILES) 

# Compile Report
$(DOCS)/%.html: $(RDIR)/%.Rmd
	@echo compiling report
	-Rscript -e  'rmarkdown::render_site("$<")'

# Clean up
clean:
	rm -fv $(DOCS_OUT_FILES)


.PHONY: all clean
