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
    @project.testcaseCount = 1

    #issue
    fileobject = File.new("in1.txt","w+");
    fileobject.syswrite(generate_integer_1d_array(20,1,10));
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
      end
    end
    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "testcases.zip"
  end



  private
  def project_params
    params.require(:project).permit(:name)
  end
end
