library(yaml)
library(htmltools)


# auto document links -----------------------------------------------------

make_doc_links <-function(document_name, video_link = TRUE){
  if(video_link){
    glue(
      '<div class="column-right">
**Files**
[<i class="fa fa-file icon-4x"></i>]({repo_url}/blob/master/{document_name}/{document_name}.pdf)
[<i class="fab fa-r-project"></i>]({repo_url}/blob/master/{document_name}/{document_name}.Rmd)
[<i class="fa fa-play-circle"></i>](https://vimeopro.com/user39539526/data-analysis-in-r)
</div>
<br>
<hr style="border-top: dotted 2px #9E7E38;" />')
  } else{
    glue(
      '<div class="column-right">
**Files**
[<i class="fa fa-file icon-4x"></i>]({repo_url}/blob/master/{document_name}/{document_name}.pdf)
[<i class="fab fa-r-project"></i>]({repo_url}/blob/master/{document_name}/{document_name}.Rmd)
</div>
<br>
<hr style="border-top: dotted 2px #9E7E38;" />')
  }
  
}


# hyperlink thumbs --------------------------------------------------------

library(htmltools)
thumbnail <- function(title, img, href, caption = TRUE) {
  div(class = "col-sm-4",
      a(class = "thumbnail", title = title, href = href,
        img(src = img),
        div(class = ifelse(caption, "caption", ""),
            ifelse(caption, title, "")
        )
      )
  )
}

# Make jumbotron ----
jumbotron <- function(text){
  div(class = "jumbotron", p(text))
}

#jumbotron("TestxxxBlehhhh")

# Make Footer from yml ----------------------------------
make_website_footer <-function(yml = "_site.yml"){
  yml <- read_yaml(yml)
  site_name <- yml[["name"]]
  instructor <- yml[["instructor"]]
  writeLines(
  glue::glue('
    <br>
      <hr>
      
      <div class="column-left">
      <p>
      <b>{site_name}</b><br>
      <a href="mailto:{yml[["email"]]}">{yml[["email"]]}</a> <br>
      </p>
      </div>
      
      <div class="column-center">
      <p>
      {yml[["address1"]]} <br>
      {yml[["address2"]]} <br>
      {yml[["address3"]]}<br>
      </p>
      
      </div>
      
      <div class="column-right">
      Michael DeWitt <br>
      <a href="https://github.com/{yml[["github"]]}"><i class="fa fa-github"></i></a>
      </div>
      
      <br>
      <br>
      <center>
      <p>Copyright &copy; 2018 {yml[["instructor"]]}. All rights reserved.</p>
      </center>
  '), "footer.html")
}

# Exanding Section ---------------------------------------

expanding_section <-function(link_title="Expand", text){
  glue::glue('<p>
        <a class="btn btn-sm" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" background-color="#4CAF50">
             {link_title}
      </a>
        </p>
        <div class="collapse" id="collapseExample">
        <div class="card card-block">
             {text}
      </div>
        </div>'
)}


# make GA automatically ---------------------------------------------------

make_google_analytics <-function(yaml = "_site.yml"){
  yml<-read_yaml("_site.yml")
  if(is.null(yml[["GA"]])){
    writeLines(" ", "GA.html")
  } else{
    GA <- yml[["GA"]]
    a <- glue::glue('<!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id={GA}"></script>')
    
    b <- sprintf("<script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      
      gtag('config', '%s');
      </script>", GA)
  }
  writeLines(c(a,b), "GA.html")
}

make_google_analytics(yaml = "_site.yml")