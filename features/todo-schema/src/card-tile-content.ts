import {ContentDescriptor, ContentSchemaBuilder,} from '@vyuh/sanity-schema-core';
import {defineField, defineType, SchemaTypeDefinition} from 'sanity';
import {IoMdCard as Icon} from 'react-icons/io';

export class CardTileContentDescriptor extends ContentDescriptor {
    static schemaName = 'todo.card.tile';

    constructor() {
        super(CardTileContentDescriptor.schemaName, {});
    }
}

export class CardTileContentSchemaBuilder extends ContentSchemaBuilder {
    schema: SchemaTypeDefinition = defineType({
        name: CardTileContentDescriptor.schemaName,
        title: 'CardTile',
        type: 'object',
        icon: Icon,
        fields: [
            defineField({
                type: 'string',
                name: 'title',
                title: 'Title',
                validation: (Rule: any) => Rule.required(),
            }),
            defineField({
                type: 'string',
                name: 'subtitle',
                title: 'Subtitle'
            }),
            defineField({
                type: 'image',
                name: 'icon',
                title: 'Icon'
            }),
            defineField({
                name: 'action',
                title: 'On Tap Action',
                description: 'Action to invoke on tile tap',
                type: 'vyuh.action',
            }),
        ],
        preview: {
            select: {
                title: 'title',
            },
            prepare(selection: any) {
                return {
                    title: `Card Tile: (${selection.title ?? 'N/A'})`,
                };
            },
        },
    });

    constructor() {
        super(CardTileContentDescriptor.schemaName);
    }

    build(descriptors: ContentDescriptor[]) {
        return this.schema;
    }
}
