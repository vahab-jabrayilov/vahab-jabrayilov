---
title: 'An Empirical Analysis of IDS Approaches in Container Securityr'

# Authors
# If you created a profile for a user (e.g. the default `admin` user), write the username (folder name) here
# and it will be replaced with their full name and linked to their profile.
authors:
  - Yigit Sever
  - Goktug Ekinci
  - Adnan Harun Dogan
  - Bugra Alparslan
  - Abdurrahman Said Gurbuz
  - admin
  - Pelin Angin

# Author notes (optional)
# author_notes:
#   - 'Equal contribution'
#   - 'Equal contribution'

date: '2022-09-19T00:00:00Z'
doi: 'https://doi.org/10.1109/SRMC57347.2022.00007'

# Schedule page publish date (NOT publication's date).
# publishDate: '2017-01-01T00:00:00Z'

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ['1']

# Publication name and optional abbreviated publication name.
publication: International Workshop on Secure and Reliable Microservices and Containers 
publication_short: In *SRMC*

abstract: Microservices architecture has been praised as a lightweight, modular and robust alternative to monolithic software in recent years with software containerization bringing parallel ideas to the table against bare metal and even virtual machine based software deployment solutions. While containers provide support for agile software development in the cloud, they suffer from security issues due to their lightweight structure not providing isolation as strong as that of virtual machines. This calls for the development of robust intrusion detection systems (IDS) for containers, taking into account their specific vulnerabilities. Existing IDS for containerized software deployments have mainly used host-based syscall monitoring, with only a few utilizing network-based monitoring without justification for the particular sensor used. In this paper, we aim to close this research gap by empirically evaluating the performances of system call and network flow based features in machine learning-based intrusion detection for containers when subjected to the same attacks. Our results show that basing the IDS on the network layer exhibits better performance than the host-based IDS for the investigated vulnerabilities, demonstrating the need for network monitoring for enhanced container security.

# Summary. An optional shortened abstract.
# summary: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere tellus ac convallis placerat. Proin tincidunt magna sed ex sollicitudin condimentum.

tags: []

# Display this page in the Featured widget?
featured: false

# Custom links (uncomment lines below)
# links:
# - name: Custom Link
#   url: http://example.org

url_pdf: 'https://ieeexplore.ieee.org/abstract/document/9973138'
# url_code: 'https://github.com/wowchemy/wowchemy-hugo-themes'
# url_dataset: 'https://github.com/wowchemy/wowchemy-hugo-themes'
# url_poster: ''
# url_project: ''
# url_slides: ''
# url_source: 'https://github.com/wowchemy/wowchemy-hugo-themes'
# url_video: 'https://youtube.com'

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
image:
  caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/pLCdAaMFLTE)'
  focal_point: ''
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
# projects:
#   - example

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
# slides: example
---
<!-- 
{{% callout note %}}
Click the _Cite_ button above to demo the feature to enable visitors to import publication metadata into their reference management software.
{{% /callout %}}

{{% callout note %}}
Create your slides in Markdown - click the _Slides_ button to check out the example.
{{% /callout %}}

Supplementary notes can be added here, including [code, math, and images](https://wowchemy.com/docs/writing-markdown-latex/). -->
