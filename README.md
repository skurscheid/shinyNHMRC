## Visualisation of NHMRC 2015 grant results using Shiny

Disclaimer: This is work-in-progress, and the result of my attempts to create (and tune) a Shiny app.

### How to run the Shiny app

1. Clone the project

    ```{bash}
    clone https://github.com/mevers/shinyNHMRC
    ```

2. Start an R session from within the project folder.

3. Run the shiny app with

    ```{R}
    library(shiny);
    runApp(".");
    ``` 

4. The app depends on the additional R packages: `RColorBrewer, ggplot2, stringr, gender`. 

    Please note: Upon installing the package `gender` for the first time, it will attempt to download additional data. This requires some user input.


### Notes

* [NHMRC 2015 grant result data](https://www.nhmrc.gov.au/_files_nhmrc/file/media/media/summary_of_results_2015_app_round_160322.xlsx). Data from the Excel sheet was converted to a CSV file using OpenOffice. Data from previous years can be found on the NHMRC ["Outcomes of funding rounds" website](https://www.nhmrc.gov.au/grants-funding/outcomes-funding-rounds).

* Gender is inferred from CIA firstnames using the R package [`gender`](https://cran.r-project.org/web/packages/gender/index.html). Details can be found in the vignette.

* Publication data for every author is stored in the RData file `journals_2015.rda`. Originally, the idea was to profile publication data in real-time; this proved to be too slow. Instead the script [`getPubs.R`](getPubs.R) reads in CIA full names, converts them to a vector of searchstrings, and uses the R package [`RefManageR`](https://cran.r-project.org/web/packages/RefManageR/index.html) to extract publication records from PubMed for every author searchstring. See [`getPubs.R`](getPubs.R) for more details.

### Author and licensing
Author: [Maurits Evers](mailto:maurits.evers@anu.edu.au) 

Date: 30 September 2016

License: GPLv3