[ch (id=UDN_how) [title How Does it Work?]

    [admon (label=Important)
        The method to define UDNs (as described in this document) might change in a future version.
        Hence the instructions in this chapter and the following ones might become obsolete.
        In the future, UDNs will possibly be defined using [xref node_id=script_nodes text="Script Nodes"].
        However, the concept of UDNs will remain the same.
    ]

    To create node [c ctext] (which we used in the example above), you just have to create a text file named [c ctext.pdml] in sub-directory [c config/nodes] of your working directory.
    PML will read this file and enable you to use node [c ctext] in your PML document.

    The content of [c config/nodes/ctext.pdml] is as follows:

    [insert_code file=[!get UDN_examples_dir]/config/nodes/ctext.pdml]

    Note the mandatory file extension used in the above example: [c pdml]. This means that the file contains a [i PDML document]. PDML stands for [i Practical Data and Markup Language]. You can easily see that PDML code looks like PML code. This is no surprise, because the PDML syntax is actually used in PML. So you don't need to learn a new syntax. Another advantage is that all PDML features (such as comments or [c u:ins_file] nodes to insert shared code) can be used to define UDNs. For more information about PDML please visit its [link url=https://pdml-lang.github.io/ text=website] or read [link url=https://pdml-lang.github.io/docs/introduction/index.html text="Introduction to PDML"].

    As can be seen in the above code:

    [list
        [el The UDN's name ([c ctext]) is defined in the PDML node [c name] with the following syntax: [c \[name ctext\]]]
        [el
            The UDN's attributes are defined in two [c attribute] nodes which are child-nodes of node [c attributes]:
            [code
                [attributes
                    [attribute
                        [name fc]
                    ]
                    [attribute
                        [name bc]
                    ]
                ]
            code]
        ]
    ]

    The most interesting part is node [c script]. This node contains Javascript code that will be executed by the PML converter to write the target HTML code. If you look at the line [c context.write ...] you can see that the Javascript code dynamically generates the HTML code we had to write manually in standard PML.

    Being able to use a very popular programming language to create UDNs is very powerful, because all Javascript language features, as well as the huge set of existing Javascript libraries can be used. For example, in case of more complex UDNs you could use the popular [link url=https://ejs.co/ text="EJS templating language"] that lets you generate HTML markup with plain JavaScript, possibly using external template files that can be adapted by users.

    Instead of using the syntax [c() (fc=red bc=yellow)] to define the foreground/background colors, we could also decide to use a shorter syntax. For example, we could use only one attribute named [c c], and separate the two colors by a slash: [c() (c=red/yellow)]. Or we could decide to use the syntax [c() (c="red on yellow")] which is a bit more readable. All this is possible because Javascript string functions can be used in a [c script] node.

    [note
        Future PML versions might add support for:
        [list
            [el other scripting languages (such as Python and Ruby)]
            [el embedded template engines like Handlebars or Mustache.]
        ]
    ]
]
