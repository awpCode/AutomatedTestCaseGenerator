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

  #  fileobject = File.new("in1.txt","w+");
    #fileobject.syswrite(generate_integer_1d_array(20,1,10));

   # fileobject.syswrite("aa");
   # @test = Testcase.new(testfile: fileobject)
   # @project.testcases << @test

    fileobject = File.new("in2.txt","w+");
    fileobject.syswrite(generate_integer_1d_array(100,1,4));
    @test = Testcase.new(testfile: fileobject)
    @project.testcases << @test

    fileobject = File.new("in3.txt","w+");
    fileobject.syswrite(generate_integer_1d_array(100,11,14));
    @test = Testcase.new(testfile: fileobject)
    @project.testcases << @test

    fileobject = File.new("in4.txt","w+");
    fileobject.syswrite(generate_integer_1d_array(200,100,400));
    @test = Testcase.new(testfile: fileobject)
    @project.testcases << @test
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
      flash[:notice] = "Article was updated successfully"
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
    url = URI("https://api.jdoodle.com/v1/execute")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url.path)
    request["Content-Type"] = 'application/json'
    @project.testcases.each do |testcase|
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
          fileobject = File.new("out1_#{rand(1..6000).to_s}.txt","w+");
          fileobject.syswrite(output);
          testcase.output = fileobject
          testcase.save
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
    params.require(:project).permit(:name, :testcaseCount, :code)
  end

end
