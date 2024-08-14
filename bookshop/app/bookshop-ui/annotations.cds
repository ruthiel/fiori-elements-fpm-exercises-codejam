using CatalogService as service from '../../srv/cat-service';

// general
annotate service.Books with {
    title  @title: 'Title';
    descr  @title: 'Description';
    author @title: 'Author';
    genre  @title: 'Genre';
    price  @title: 'Price';
    stock  @title: 'Stock';
};

annotate service.Books with @(
    UI                            : {
        SelectionFields: [
            genre_ID,
            author_ID
        ],
        HeaderInfo     : {
            TypeName      : 'Book',
            TypeNamePlural: 'Books',
            Title         : {Value: title},
            Description   : {Value: author.name}
        },
        Identification : [{Value: ID}],
        LineItem       : {
            $value            : [
                {
                    $Type            : 'UI.DataField',
                    Value            : title,
                    ![@UI.Importance]: #High
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : author.name,
                    Label            : 'Author',
                    ![@UI.Importance]: #High
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : genre.name,
                    Label            : 'Genre',
                    ![@UI.Importance]: #Medium
                },
                {
                    $Type            : 'UI.DataField',
                    Value            : price,
                    ![@UI.Importance]: #Medium
                },
                {
                    $Type                    : 'UI.DataField',
                    Value                    : stock,
                    Criticality              : criticality,
                    CriticalityRepresentation: #WithoutIcon,
                    ![@UI.Importance]        : #Medium
                }
            ],
            ![@UI.Criticality]: criticality // criticality for whole line item
        }
    },
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
            },
            {
                $Type: 'UI.DataField',
                Value: author.name,
            },
            {
                $Type: 'UI.DataField',
                Value: genre.name,
            },
            {
                $Type: 'UI.DataField',
                Value: stock,
            },
            {
                $Type: 'UI.DataField',
                Value: price,
            },
        ],
        Label: 'General Information',
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Information',
        ID    : 'GeneralFacet1',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ],
);

annotate service.Sales with @(

    UI.Chart                         : {
        $Type              : 'UI.ChartDefinitionType',
        ChartType          : #Line,
        DynamicMeasures    : ['@Analytics.AggregatedProperty#sum'],
        MeasureAttributes  : [{
            $Type         : 'UI.ChartMeasureAttributeType',
            DynamicMeasure: '@Analytics.AggregatedProperty#sum',
            Role          : #Axis1
        }],
        Dimensions         : [date],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: date,
            Role     : #Category
        }]
    },

    Analytics.AggregatedProperty #sum: {
        Name                : 'sumSales',
        AggregationMethod   : 'sum',
        AggregatableProperty: 'price',
        ![@Common.Label]    : 'Sum Sales'
    },

    Aggregation.ApplySupported       : {
        Transformations         : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'top',
            'skip',
            'orderby',
            'search'
        ],
        CustomAggregationMethods: ['Custom.concat'],
        Rollup                  : #None,
        PropertyRestrictions    : true,
        GroupableProperties     : [date],
        AggregatableProperties  : [{Property: price}]
    }

);
