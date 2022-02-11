[ch [title Specification]

    [ch [title Defining UDNs]

        UDNs are defined in a [link url=https://pdml-lang.github.io/ text=PDML] document.

        The mandatory root node of a UDN is named [c node].

        [ch (id=UDN_name) [title Node Name]

            Node [c node] must have exactly one child-node named [c name], which defines the UDN's name. For example, a UDN with name [c ctext] is defined as follows:
            [code
                [node
                    [name ctext]
                    ...
                ]
            code]

            A node name must match the regex [c \[a-zA-Z_\]\[a-zA-Z0-9_\\.-\]*]. This means that a name starts with a letter or an underscore ([c _]), optionally followed by any number of letters, digits, underscores ([c _]), dots ([c .]), or hyphens ([c -]).

[-
            To avoid clashes of UDN names with future standard PML node names it is recommended to suffix UDN node names with an underscore (e.g. [c my_node_name_]), unless you think it's very unlikely that your UDN name will ever be used for a standard PML node.
-]

            Node names must be unique. If a UDN name clashes with an existing PML node name or another UDN name, an error is generated.

            [note
                A future PML version might support explicitly overriding the target code generation of standard PML nodes, by using UDNs. This would allow to partially (or even completely) override the converter's output generation process.
            ]
        ]


        [ch [title Script]

            Node [c node] must have exactly one child-node named [c writer].

            Node [c writer] must have exactly one child-node named [c script].

            Node [c script] contains the Javascript code used to generate the target code (e.g. HTML).

            The Javascript code must be embedded between a pair of so-called [i fence lines] - an opening fence line, and a closing fence line. A fence line is composed of an optional indent (spaces and tabs), followed by 3 or more identical characters which must be either [c "], [c =], or [c ~], followed by a new line. Examples of valid fences: [c """], [c ====], [c ~~~~~~~~~~]. The opening fence line must contain at least 3 characters. The closing fence line must contain at least as many characters as the opening fence line.

            Here is a working example of a UDN named [c smiley] that can be used to insert a smiley in a PML document with the syntax [c \[smiley\]]:

            [caption File config/nodes/smiley.pdml]
            [insert_code file=[!get UDN_examples_dir]/config/nodes/Unicode_chars/smiley.pdml]

            As can be seen, the Javascript code [c context.write ( '...' )] is used to write HTML code.
        ]


        [ch [title Attributes]

            Node [c node] can optionally have exactly one child-node named [c attributes]. This node is used to define optional UDN attributes.

            Node [c attributes] can optionally have any number of child-nodes named [c attribute]. Each [c attribute] node is used to define one attribute.

            An [c attribute] node must have exactly one child-node named [c name]. [c name] is a text node that defines the attribute's name, e.g. [c \[name foo\]]. Attribute names must be unique within a UDN, and they must respect the same naming rule as specified in [xref node_id=UDN_name].

            An [c attribute] can optionally have exactly one child-node named [c default]. [c default] is a text node that defines the attribute's default value. The default value is the attribute's value that will be used if no value is explicitly defined in the PML code that uses the UDN.

            Suppose an UDN has three attributes:
            [list
                [el attribute [c color] with no default value]
                [el attribute [c width] with a default value of 200]
                [el attribute [c height] with a default value of 100]
            ]

            This would be specified as follows:

            [code
                [attributes
                    [attribute
                        [name color]
                    ]
                    [attribute
                        [name width]
                        [default 200]
                    ]
                    [attribute
                        [name height]
                        [default 100]
                    ]
                ]
            code]

            [note
                Whitespace between nodes is optional. The above code could also be written more succinctly like this:
                [code
                    [attributes
                        [attribute [name color]]
                        [attribute [name width] [default 200]]
                        [attribute [name height][default 100]]
                    ]
                code]
            ]
        ]

        [ch (id=UDN_list_of_nodes) [title List of Nodes]

            If a single file contains several UDNs then all [c node] nodes must be child-nodes of a single root node named [c nodes], like this:
            [code
                [nodes
                    [node
                        [name node_1]
                        ...
                    ]
                    [node
                        [name node_2]
                        ...
                    ]
                    ...
                ]
            code]
        ]
    ]

    [ch [title Files And Directories]

        A UDN is defined in a single file, a so-called [i UDN definition file]. The file extension must be [c pdml]. The file name (without extension) is irrelevant. However, a UDN with name [c foo] would typically be stored in file [c foo.pdml].

        A single file can contain one or more UDNs, as shown in chapter [xref node_id=UDN_list_of_nodes].

        When the PML converter is launched, it uses the following rules (by default) to locate UDN definition files:
        [list
            [el	PML searches for UDN definition files in sub-directory [c config/nodes] of the current working directory. If no such directory exists, then no UDNs are used.]
            [el Files in [i sub]-directories of [c config/nodes] are included in the search.]
            [el	Files with an extension different from [c pdml] are ignored (including files with no extension).]
            [el	Files and sub-directories whose name starts with [c ---] are ignored. This is useful to temporarily disable UDN definition files.]
        ]

        Some PML commands support parameter [c user_defined_nodes_directories] (shortcut [c udnd]) to override the default behavior and explicitly define a list of directories in which to search for UDN definition files. For more information please consult the documentation for parameter [c user_defined_nodes_directories]. To do this, you can type the following command in a terminal, and look for parameter [c user_defined_nodes_directories]:
        [input
            pmlc command_info --command convert
        input]

        For example, to use document-specific UDNs defined in directory [c config/nodes], as well as shared UDNs in directory [c ../../shared/nodes] you would use the parameter as follows (replace ; with : on Unix/Linux):
        [input
            -udnd config/nodes;../../shared/nodes
        input]

        [note
            In a future version it might be possible to also define UDNs programmatically, via PML's API.
        ]
    ]

    [ch [title Scripts]

        The following PML-specific data and functions are available in a UDN [c script] node:
        [list
            [el
                [c attributes]

                This is an object containing all UDN attributes defined in the PML document.

                Each attribute value is a string.

                To get an attribute's value, function [c get] can be used, e.g. [c attributes.get ( "color" )]

                If an attribute exists in the UDN definition file, but no value is assigned in the PML document then:
                [list
                    [el If the attribute has a default value defined in the UDN definition file, then its default value is used.]
                    [el If no default value is defined, then an error is generated by the PML converter.]
                ]
            ]
            [el
                [c context]

                This is an object with a set of functions. The following functions are available.

                [list
                    [el
                        [c write ( string )]

                        Write [c string] to the converter's output stream (e.g. HTML target file).
                    ]
                    [el
                        [c writeNewLine()]

                        Write an OS-dependant new line to the converter's output stream (LF on Linux/Unix, CRLF on Windows).
                    ]
                    [el
                        [c writeLine ( string )]

                        Write [c string], followed by an OS-dependant new line to the converter's output stream.
                    ]
                    [el
                        [c writeChildNodes()]

                        Write the UDN's child nodes to the converter's output stream.

                        This function must be called after writing the node's opening code (e.g. the HTML start tag), and before writing the node's closing code (e.g. the HTML end tag). Failing to call this function will result in all of the UDN's child nodes not being displayed in the final document.
                    ]
                ]
            ]
        ]
    ]

    [ch [title Usage]

        As seen in the previous chapters, when the PML converter is launched, it looks for UDN definition files in directory [c config/nodes] or any other directories defined by command line argument [c user_defined_nodes_directories] (shortcut [c udnd]). As a result, a list of UDNs is created, and these UDNs are all available in the PML document that is to be converted.

        The syntax for using UDNs in a PML document is exactly the same as for standard PML nodes.
    ]
]
