import {ContentDescriptor, ContentSchemaBuilder,} from '@vyuh/sanity-schema-core';
import {defineField, defineType, SchemaTypeDefinition} from 'sanity';
import {IoIosAlbums as Icon} from 'react-icons/io';

export class TileContentDescriptor extends ContentDescriptor {
    static schemaName = 'schema.tile.content';

    constructor() {
        super(TileContentDescriptor.schemaName, {});
    }
}

export class CardTileContentSchemaBuilder extends ContentSchemaBuilder {
    schema: SchemaTypeDefinition = defineType({
        name: TileContentDescriptor.schemaName,
        title: 'Tile',
        type: 'object',
        icon: Icon,
        fields: [
            defineField({
                name: 'title',
                title: 'Title',
                type: 'string',
            }),
            defineField({
                name: 'subtitle',
                title: 'subtitle',
                type: 'string',
            }),
        ],
        preview: {
            select: {
                title: 'title',
                subtitle: 'subtitle',
            },
            prepare(selection: any) {
                return {
                    title: `Tile: (${selection.title ?? 'N/A'})`,
                    subtitle: `Subtitle: (${selection.subtitle ?? 'N/A'})`,
                };
            },
        },
    });

    constructor() {
        super(TileContentDescriptor.schemaName);
    }

    build(descriptors: ContentDescriptor[]) {
        return this.schema;
    }
}