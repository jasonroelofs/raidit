require File.join(File.dirname(__FILE__), "base")

describe Hassle::Compiler do
  before do
    reset
    @hassle = Hassle::Compiler.new
  end

  it "dumps css into separate folders" do
    @hassle.css_location("./public/stylesheets/sass").should ==
      File.join(Dir.pwd, "tmp", "hassle", "stylesheets")

    @hassle.css_location("./public/css/compiled").should ==
      File.join(Dir.pwd, "tmp", "hassle", "css", "compiled")

    @hassle.css_location("./public/styles/posts/sass").should ==
      File.join(Dir.pwd, "tmp", "hassle", "styles", "posts")
  end

  describe "compiling sass" do
    before do
      @default_location = Sass::Plugin.options[:css_location]
    end

    it "moves css into tmp directory with default settings" do
      sass = write_sass(File.join(@default_location, "sass"))

      @hassle.compile

      sass.should be_compiled
      @hassle.stylesheets.should have_tmp_dir_removed(sass)
    end

    it "should not create sass cache" do
      write_sass(File.join(@default_location, "sass"))
      Sass::Plugin.options[:cache] = true

      @hassle.compile

      File.exists?(".sass-cache").should be_false
    end

    it "should compile sass even if disabled with never_update" do
      sass = write_sass(File.join(@default_location, "sass"))
      Sass::Plugin.options[:never_update] = true

      @hassle.compile

      sass.should be_compiled
    end

    it "should compile sass if template location is not specified" do
      template_directory = "public/stylesheets/sass"
      output_directory = "public/stylesheets"
      Sass::Plugin.options[:template_location] = nil
      sass_template = write_sass(template_directory)
      template_name = File.basename(sass_template)

      @hassle.compile

      css_location = @hassle.css_location(template_directory)
      css_file = @hassle.css_location(File.join(output_directory, File.basename(sass_template)))
      css_file.should be_compiled
    end

    it "should compile sass if template location is a hash" do
      template_directory = "public/css/sass"
      output_directory = "public/css"
      Sass::Plugin.options[:template_location] = {template_directory => output_directory}
      sass_template = write_sass(template_directory)
      template_name = File.basename(sass_template)

      @hassle.compile

      css_location = @hassle.css_location(template_directory)
      css_file = @hassle.css_location(File.join(output_directory, File.basename(sass_template)))
      css_file.should be_compiled

      @hassle.stylesheets.should == ['/css/screen.css']
    end

    it "should compile sass if template location is a hash with multiple locations" do
      template_directory_one = "public/css/sass"
      output_directory_one = 'public/css'
      template_directory_two = "public/stylesheets/sass"
      output_directory_two = 'public/css'
      Sass::Plugin.options[:template_location] = {template_directory_one => output_directory_one, template_directory_two => output_directory_two}
      sass_one = write_sass(template_directory_one, "one")
      sass_two = write_sass(template_directory_two, "two")

      @hassle.compile

      css_location = @hassle.css_location(template_directory_one)
      css_file = @hassle.css_location(File.join(output_directory_one, File.basename(sass_one)))
      css_file.should be_compiled

      css_location = @hassle.css_location(template_directory_two)
      css_file = @hassle.css_location(File.join(output_directory_two, File.basename(sass_two)))
      css_file.should be_compiled

      @hassle.stylesheets.each do |s|
        ["/css/one.css", "/css/two.css"].should include(s)
      end
    end

    it "should compile sass if template location is an array with multiple locations" do
      template_directory_one = "public/css/sass"
      output_directory_one = 'public/css'
      template_directory_two = "public/stylesheets/sass"
      output_directory_two = 'public/css'
      Sass::Plugin.options[:template_location] = [[template_directory_one, output_directory_one], [template_directory_two, output_directory_two]]
      sass_one = write_sass(template_directory_one, "one")
      sass_two = write_sass(template_directory_two, "two")

      @hassle.compile

      css_location = @hassle.css_location(template_directory_one)
      css_file = @hassle.css_location(File.join(output_directory_one, File.basename(sass_one)))
      css_file.should be_compiled

      css_location = @hassle.css_location(template_directory_two)
      css_file = @hassle.css_location(File.join(output_directory_two, File.basename(sass_two)))
      css_file.should be_compiled

      @hassle.stylesheets.each do |s|
        ["/css/one.css", "/css/two.css"].should include(s)
      end
    end

    it "should not overwrite similarly name files in different directories" do
      template_directory_one = "public/css/sass"
      output_directory_one = 'public/css'
      template_directory_two = "public/stylesheets/sass"
      output_directory_two = 'public/css'
      Sass::Plugin.options[:template_location] = [[template_directory_one, output_directory_one], [template_directory_two, output_directory_two]]
      sass_one = write_sass(template_directory_one, "screen")
      sass_two = write_sass(template_directory_two, "screen")

      @hassle.compile

      css_location = @hassle.css_location(template_directory_one)
      css_file = @hassle.css_location(File.join(output_directory_one, File.basename(sass_one)))
      css_file.should be_compiled

      css_location = @hassle.css_location(template_directory_two)
      css_file = @hassle.css_location(File.join(output_directory_two, File.basename(sass_two)))
      css_file.should be_compiled

      @hassle.stylesheets.each do |s|
        ["/css/screen.css", "/css/screen.css"].should include(s)
      end
    end
  end
end
