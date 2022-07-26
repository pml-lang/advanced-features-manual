[ch [title Why Are They Useful?]

    Suppose we have to write a document in which the foreground and background colors of text snippets change often. Some text is written in red on yellow, other text in blue on orange, etc. Moreover we want these text snippets to have a rounded border with the same color as the text. Here is an example of how it would look like in the final document:

    [image source=images/ctext_example.png border=yes]

    In standard PML, we could achieve this with code like this:

    [code
        Some text is [span ( html_style="color: red; background-color: yellow; border: 1px solid red; padding:5px; border-radius: 3px;" ) red on yellow]

        Some text is [span ( html_style="color: blue; background-color: orange; border: 1px solid blue; padding:5px; border-radius: 3px;" ) blue on orange]
    code]

    Needless to say, this works, but it's [i not user-friendly]. If these [c span] nodes are used often, it will quickly become cumbersome and unmaintainable to repeat this boilerplate code again and again. Not enjoyable!

    What we would [i want] to write is simple code like this:

    [code
        Some text is [ctext (fc=red bc=yellow) red on yellow]

        Some text is [ctext (fc=blue bc=orange) blue on orange]
    code]

    As can be seen in the above code, we would like to have a node with name [c ctext] (colored text) and two attributes ([c fc] and [c bc]) to define the foreground/background colors.

    But PML doesn't have a [c ctext] node!

    You could ask the PML developers to add a [c ctext] node to PML. Although it would be easy for them to do that, they would kindly decline your request. Why? Because PML must remain [i simple] for everybody. There are hundreds of nodes that [i could] be added to PML because [i some] users might need them. But that would increase PML's complexity dramatically for everybody, and create maintenance nightmares for developers.

    For example, imagine that PML provided culture-dependant nodes to cover specific needs that depend on the country/region in which the readers live. People in French would be happy to have specific support for so-called guillemets ([c «] and [c »]) which are used as quotation marks in the french language. However, people in other regions of the world never use guillemets, but they might have [i other] desiderata to cover [i their] specific needs. To avoid chaos and an unmaintainable proliferation of nodes, PML only provides a standard set of common nodes that are used frequently by most writers.

    Wouldn't it be nice if you could just add your specific nodes [i yourself] and customize them to your needs?

    That would be convenient, and therefore PML provides a feature called [i user-defined nodes].

    A [i user-defined node (UDN)] is a node which you can add yourself to PML, to cover your specific needs. You can do this by providing a configuration file that defines the properties and behavior of your UDN. You can define as many UDNs as you need. A single file can define one or more UDNs. You can use a set of files which can be located in different directories. For example, you can
    [list
        [el use one directory to define global UDNs used in all your documents]
        [el use other directories to define specific nodes only used in specific documents]
    ]
    Because UDNs are defined in simple text files, they can easily be shared and maintained in a source code repository of a version control service such as Github or Gitlab. Thus UDNs can benefit from all the powerful features provided by such community services. For example, users could share and maintain their culture-specific UDNs in a repository, to help other users located in the same country or region.
]
