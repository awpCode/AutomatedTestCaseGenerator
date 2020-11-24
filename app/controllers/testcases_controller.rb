class TestcasesController < ApplicationController
    def download
        download = Testcase.find(params[:format].to_i)
        send_file download.testfile.path,
        :filename => download.testfile_file_name,
        :type => download.testfile_content_type,
        :disposition => 'attachment'
        flash[:notice] = "Your file has been downloaded"
    end
end
