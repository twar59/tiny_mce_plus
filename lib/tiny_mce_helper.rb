module TinyMCEHelper
  class InvalidOption < Exception    
  end
  
  def using_tiny_mce?
    !@uses_tiny_mce.nil?
  end
  
  def single_tiny_mce_init(options, flush = true)
    options ||= {}
    default_options = {:mode => 'textareas',
                       :theme => 'simple'}
    options = default_options.merge(options)
    TinyMCE::OptionValidator.plugins = options[:plugins]
    tinymce_js = "$('textarea.tinymce').tinymce({\n"
    tinymce_js += "script_url: '/javascripts/tiny_mce/tiny_mce.js',\n"
    i = 0    
    options.stringify_keys.sort.each do |pair|
      key, value = pair[0], pair[1]
      raise InvalidOption.new("Invalid option #{key} passed to tinymce") unless TinyMCE::OptionValidator.valid?(key)
      tinymce_js += "#{key} : "
      case value
      when String, Symbol, Fixnum
        tinymce_js += "'#{value}'"
      when Array
        tinymce_js += '"' + value.join(',') + '"'
      when TrueClass
        tinymce_js += 'true'
      when FalseClass
        tinymce_js += 'false'
      else
        raise InvalidOption.new("Invalid value of type #{value.class} passed for TinyMCE option #{key}")
      end
      (i < options.size - 1) ? tinymce_js += ",\n" : "\n"
      i += 1
    end
    tinymce_js += "\n});"
    flush ? javascript_tag(tinymce_js) : tinymce_js
  end
  
  def tiny_mce_init(options = @tiny_mce_options)
    options = [options] unless options.is_a?(Array)
    tinymce_js = '$(document).ready(function(){'
    options.each do |mce_options|
    	tinymce_js << single_tiny_mce_init(mce_options, false)
    end
    tinymce_js += '});'
    javascript_tag(tinymce_js)
  end
  alias tiny_mce tiny_mce_init

end