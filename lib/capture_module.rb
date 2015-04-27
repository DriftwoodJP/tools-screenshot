module CaptureModule
  VERSION = '0.0.3'

  def get_html(uri, options)
    begin
      open(uri, options) { |f| f.read }
    rescue => e
      puts [uri.to_s, e.class, e].join(' : ')
    end
  end

  module_function :get_html

  def get_anchors(html, uri, base_uri)
    anchors = []
    html.css('a[href]').each do |anchor|
      p anchor[:href]
      if anchor[:href] =~ URI::regexp
        anchors.push(URI(anchor[:href]).normalize.to_s)
      else
        if uri.is_a?(OpenURI::Meta) # from www
          anchors.push(URI.join(uri, anchor[:href]).normalize.to_s)
        else # from file
          anchors.push(URI.join(base_uri, anchor[:href]).normalize.to_s)
        end
      end
    end
    anchors
  end

  module_function :get_anchors
end
