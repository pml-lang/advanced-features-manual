[ch [title Examples]

    [ch [title Unicode Characters]

        Suppose we want to insert a smiley (😀) into a PML document. The final result should look like this:
        [output
            Hi there 😃
        output]

        Without UDNs, there are three ways to achieve this:
        [list (html_style="list-style-type:decimal")
            [el
                Copy/paste the smiley into the document.

                This works because PML documents are encoded in UTF-8, which means that all Unicode characters can be inserted into a document.

                To copy/paste the smiley you could search the net for 'unicode smiley', head to a page like [link url=https://unicode.org/emoji/charts/full-emoji-list.html text="this one"], and copy/paste the smiley.

                Your PML code would look like this:
                [code
                    Hi there 😃
                code]

                ... which would result in the same text displayed in the browser:
                [output
                    Hi there 😃
                output]

                [note
                    Unicode characters will only be rendered in the final HTML document if they are supported by the font and browser.
                ]
            ]

            [el
                Insert the smiley's [link url=https://www.pml-lang.dev/docs/user_manual/index.html#escape_characters text="Unicode escape sequence"], which is [c U+1F600].

                PML code:
                [code
                    Hi there \U0001F600
                code]
            ]

            [el
                Use a [link url=https://www.pml-lang.dev/docs/reference_manual/index.html#node_verbatim text=verbatim] node to insert the HTML escape sequence, which is [c &#128515;].

                PML code:
                [code
                    Hi there [verbatim &#128515;]
                code]
            ]
        ]

        None of the above methods is really convenient. If you use smileys often (or any other Unicode character), you can define a [c smiley] UDN. Proceed like this:
        [list
            [el
                Create file [c smiley.pdml] in directory [c config/nodes], with the following content:
                [insert_code file=[!get UDN_examples_dir]/config/nodes/Unicode_chars/smiley.pdml]

                The [c smiley] UDN is now ready to be used.
            ]

            [el
                Insert the following markup code in your PML document:
                [code
                    Hi there [smiley]
                code]
            ]

            [el
                Result displayed in the browser:
                [code
                    Hi there 😃
                code]
            ]
        ]

        You can create your own UDNs for all Unicode characters you use often in your documents. For example you could define a set of UDNs for emojis, math symbols, foreign language characters, arrows and other symbols, etc. Look at a Unicode table like [link url=https://unicode-table.com text="this one"] to get inspired.

        Here is an example of a single UDN definition file for three math symbols:

        [caption File config/nodes/maths.pdml]
        [insert_code file=[!get UDN_examples_dir]/config/nodes/Unicode_chars/maths.pdml]

        These UDNs will allow you to write PML code like this:
        [code
            Pi: [pi]

            Infinity: [infinity]

            Integral: [integral]
        code]

        ... which will be rendered as follows:
        [output
            Pi: π

            Infinity: ∞

            Integral: ∫
        output]

        [note
            If you think that the above UDN definition file [c maths.pdml] risks to become unmaintainable, repetitive boilerplate code that should be changed from WET to [link url=https://en.wikipedia.org/wiki/Don%27t_repeat_yourself text=DRY], you are not alone.

            A future version will allow you to create a Javascript function that eliminates the code repetition. Then the three math nodes can be defined with simple function calls like this:
            [code
                createNode ( "π", "pi", "960" )
                createNode ( "∞", "infinity", "8734" )
                createNode ( "∫", "integral", "8747" )
            code]

            It will then be easier to add more nodes. The code will also be easier to maintain. For example, if you later decide to use a specific font for all math nodes, you just need to make a single change in the function that generates the boilerplate.

            Alternatively you will also be able to use a template engine.
        ]

[-
        Note that the above UDN would always use the font of the surrounding text. This might result in different/ugly symbols, or symbols not rendered if they are not supported by the current font.
-]
    ]
]
