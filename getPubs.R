# This script downloads all publications based on a query character vector
# of author names in the format "SURNAME, FIRSTNAME".
#
# The ReadPubMed routine throws "Request-URI Too Large" errors very easily,
# so unfortunately this is not very reliable. It would have been better to
# try and catch the error and continue with the next entry from the query
# vector.
# See also issue on github https://github.com/mwmclean/RefManageR/issues/19
# One way around the issue is to reduce retmax!

# Author: Maurits Evers
# License: GPLv3

getPubs <- function(ss, retmax = 100, mindate = 2010, maxdate = 2016) {
    # Load library to allow communication with PubMed
    require(RefManageR);
    require(pbapply);
    # Search for author in PubMed
    lst <- pblapply(ss, function(x) {
        suppressMessages(
        ReadPubMed(x,
                   database = "PubMed",
                   field = "author",
                   retmax = retmax,
                   mindate = mindate,
                   maxdate = maxdate))
    });
    names(lst) <- names(ss);
    return(lst);
}

# Read in CSV file with 2015 NHMRC data
d <- read.csv("summary_of_results_2015_app_round_160322.csv",
              stringsAsFactors = FALSE);


# Format search string from CIA
CIA <- unique(d$CIA_Name[which(d$CIA_Name != "")]);
names <- strsplit(CIA, " ");
#ss <- sapply(CIA, function(x) paste(rev(x[-1]), collapse = ", "));
ss <- sapply(names, function(x)
             paste(c(paste(x[3:length(x)], collapse = " "), x[2]),
                   collapse = ", "));
names(ss) <- CIA;
ss <- ss[order(ss)];

# Optionally write authors to file
#write.table(ss, file = "authors.txt", quote = FALSE, sep = "\t",
#            row.names = FALSE, col.names = FALSE);

# Get entries from PubMed
ret <- getPubs(ss);

# Write journals to file
journals <- lapply(ret, function(x)
                   sapply(x, function(y)
                          y$journal));
save(journals, file = "journals_2015.rda");
