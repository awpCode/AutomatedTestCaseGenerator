class TestcasesController < ApplicationController
    def download_input
        download = Testcase.find(params[:format].to_i)
        send_file download.testfile.path,
        :filename => download.testfile_file_name,
        :type => download.testfile_content_type,
        :disposition => 'attachment'
        flash[:notice] = "Your file has been downloaded"
    end
    def download_output
        download = Testcase.find(params[:format].to_i)
        send_file download.output.path,
        :filename => download.output_file_name,
        :type => download.output_content_type,
        :disposition => 'attachment'
        flash[:notice] = "Your file has been downloaded"
    end

end
