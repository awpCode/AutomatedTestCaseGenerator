# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



    <script>
        SEC_HTTPS = true;
        SEC_BASE = "compilers.widgets.sphere-engine.com";
        (function(d, s, id){ SEC = window.SEC || (window.SEC = []);
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return; js = d.createElement(s); js.id = id;
        js.src = (SEC_HTTPS ? "https" : "http") + "://" + SEC_BASE + "/static/sdk/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
        }(document, "script", "sphere-engine-compilers-jssdk"));
        SEC.ready=function(e){"loading"!=document.readyState&&"interactive"!=document.readyState?e():window.addEventListener("load",e)};
    </script>

  <div class="sec-widget mt-4" data-widget="2adbe0da9448563569f4c6416339b355"></div>

      <div class="form-group row">
      <%= f.label :code,class: "col-2 col-form-label text-light" %>
      <div class="col-10">
         <%= f.text_area :code, rows: 10,class: "form-control shadow rounded",placeholder: "Write your C++ code here" %>
      </div>
    </div>



        <%=  link_to 'Save', project_path(@project),method: :patch,:class => "btn btn-dark text-center"  %>