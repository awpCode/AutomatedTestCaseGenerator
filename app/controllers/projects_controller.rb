require 'zip'
class ProjectsController < ApplicationController
  def show
  @project = Project.find(params[:id])
  end
  def index
  @projects =  current_user.projects
  end
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project.user = current_user
    a = @project.tests
    #Creating testcases
    #int intarray int2darray string stringarray
    for i in 1..@project.testcaseCount

        inputFileName = "in" + i.to_s + ".txt"
        fileobject = File.new(inputFileName,"w+");
        input = ""
        a.each do |test|
          if test.name.blank?
            test.destroy
            next
          elsif test.name == "int"
            input += generate_integer(test.lowlimit, test.highlimit) + " "
          elsif test.name == "intarray"
            input += generate_integer_1d_array(test.rowsize,test.lowlimit,test.highlimit)
          elsif test.name == "int2darray"
            input += generate_integer_2d_array(test.rowsize,test.colsize,test.lowlimit,test.highlimit)
          elsif test.name == "string"
            input += generate_string(test.rowsize,test.rowsize,test.flag) + " "
          elsif test.name == "stringarray"
            input += generate_string_array(test.rowsize,test.lowlimit,test.highlimit,test.flag)
          end
        end

        fileobject.syswrite(input);
        @test = Testcase.new(testfile: fileobject)
        @project.testcases << @test
    end


    if @project.save
      flash[:notice] = "Project was created successfully."
      redirect_to project_path(@project)
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    #generate testcases again
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project was updated successfully"
      redirect_to project_path(@project)
    else
     render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end

  #download all testcases in a zip
  def process_and_create_zip_file
    @project = Project.find(params[:format].to_i)
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      @project.testcases.each do |p|
        zos.put_next_entry p.testfile_file_name
        zos.print(Paperclip.io_adapters.for(p.testfile).read)


        zos.put_next_entry p.output_file_name
        zos.print(Paperclip.io_adapters.for(p.output).read)

      end
    end
    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "testcases.zip"
  end


  def generate_output
    @project = Project.find(params[:format].to_i)
    if @project.code.blank?
      flash[:error] = "Add code to your project first"
    else
        url = URI("https://api.jdoodle.com/v1/execute")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(url.path)
        request["Content-Type"] = 'application/json'
        @project.testcases.each_with_index do |testcase, index|
          #input = testcase.testfile.copy_to_local_file.read.to_s
          input = Paperclip.io_adapters.for(testcase.testfile).read
          input = input.to_s
          request.body = {
              "script" => @project.code,
              "language" => "cpp14",
              "versionIndex" => "3",
              "clientId" => "b4a3fb2dd2327ec7e9189ac3a0fc8c38",
              "clientSecret" => "f295f87cb2647b7a77ada106ff601a80b1b732aec52c34df2b79202ac55671f0",
              "stdin" => input}.to_json
              response = http.request(request)
              obj = JSON.parse(response.read_body)
              output = obj["output"].to_s
              output = " " + output
              outputFileName = "out" + (index+1).to_s  + ".txt"
              fileobject = File.new(outputFileName,"w+");
              fileobject.syswrite(output);
              testcase.output = fileobject
              testcase.save
        end
     end
    render 'show'
  end
    def add_code
      @project = Project.find(params[:format].to_i)
    end
    def online_ide

    end

  private
  def project_params
    params.require(:project).permit(:name, :testcaseCount, :code, tests_attributes: [:id ,:name, :lowlimit, :highlimit, :rowsize, :colsize, :flag])
  end

end
