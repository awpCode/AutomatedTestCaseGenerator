class ModelValidator < ActiveModel::Validator
  def validate(record)

    #Range Validation
    if record.name != "string"
      if record.lowlimit.blank?
        record.errors[:base] << "Lowlimit must be present"
      elsif record.highlimit.blank?
        record.errors[:base] << "Highlimit must be present"
      elsif record.lowlimit < 0 || record.highlimit < 0
        record.errors[:base] << "Limits must be positive"
      elsif record.lowlimit > 100000000 || record.highlimit > 100000000
        record.errors[:base] << "Limits must be less than or equal to 100000000"
      elsif record.lowlimit > record.highlimit
        record.errors[:base] << "Lowlimit must be less than or equal to HighLimit"
      end
    end

    #Flag Validation
    if record.name == "string" || record.name == "stringarray"
      if record.flag.blank?
          record.errors[:base] << "Flag must be present"
      elsif record.flag < 0 || record.flag > 3
          record.errors[:base] << "Flag must be in between 0 and 2(both inclusive)"
      end
    end

    #rowsize validation
    if record.name == "string" || record.name == "stringarray" || record.name == "intarray" || record.name == "int2darray"
      if record.rowsize.blank?
        record.errors[:base] << "Size must be present"
      elsif record.rowsize < 0 || record.rowsize > 100000
          record.errors[:base] << "Size must be in between 0 and 100000(both inclusive)"
      end
    end

    #colsize validation
    if record.name == "int2darray"
      if record.colsize.blank?
        record.errors[:base] << "Number of Columns must be present"
      elsif record.colsize < 0 || record.colsize > 100000
          record.errors[:base] << "Number of columns must be in between 0 and 100000(both inclusive)"
      end
    end

    #rowsize*colsize validation
    if record.name == "int2darray"
      if record.colsize * record.rowsize > 10000000
        record.errors[:base] << "Reduce Matrix Size"
      end
    end


  end

end
class Test < ApplicationRecord
    belongs_to :project
    validates_with ModelValidator
end
