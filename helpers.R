# Function to put two numeric input boxes side-by-side
# Adjusted from the following link on SO:
# http://stackoverflow.com/questions/20637248/shiny-4-small-textinput-boxes-side-by-side
pNumericInput<-function (inputId, label, value = 0, ...) {
    div(style="display:inline-block",
        tags$label(label, `for` = inputId), 
        tags$input(id = inputId, type = "number", value = value, ...))
}