set :site_description, 'Blog posts about the technical and non-technical work in the software industry'
set :markdown_engine, :redcarpet
set :markdown, strikethrough: true, with_toc_data: true

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :livereload

activate :blog do |blog|
  blog.layout = 'weekly_layout'
  blog.name = 'weekly'
  blog.paginate = true
  blog.permalink = 'posts/{title}.html'
  blog.sources = 'content/weekly/{year}-{month}-{day}-{title}.html'
end

activate :blog do |blog|
  blog.layout = 'blog_layout'
  blog.name = 'blog'
  blog.permalink = 'posts/{title}.html'
  blog.sources = 'content/blog/{year}-{month}-{day}-{title}.html'
end

activate :directory_indexes

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def current_url(path)
    config[:protocol] + host_with_port + path
  end

  def image_url(source)
    config[:protocol] + host_with_port + image_path(source)
  end

  def host_with_port
    [config[:host], optional_port].compact.join(':')
  end

  def optional_port
    config[:port] unless config[:port].to_i == 80
  end
end

# Development-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
  activate :external_pipeline,
    name: :gulp,
    command: 'yarn develop',
    source: '.tmp',
    latency: 1

  set :protocol, 'http://'
  set :host, 'localhost'
  set :port, 4567
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :external_pipeline,
    name: :gulp,
    command: 'yarn build',
    source: '.tmp',
    latency: 1

  ignore 'stylesheets/components/*.css'
  ignore 'stylesheets/utilities/*.css'

  set :protocol, 'https://'
  set :host, 'www.flashover.blog'
  set :port, 80
end
