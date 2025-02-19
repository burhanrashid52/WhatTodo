import {ContentDescriptor, ContentSchemaBuilder,} from '@vyuh/sanity-schema-core';
import {defineField, defineType, SchemaTypeDefinition} from 'sanity';
import {IoMdCard as Icon} from 'react-icons/io';
import {CardTileContentDescriptor} from "./card-tile-content.ts";

export class GroupCardContentDescriptor extends ContentDescriptor {
    static schemaName = 'todo.group.card';

    constructor(props: Partial<GroupCardContentDescriptor>) {
        super(GroupCardContentDescriptor.schemaName, props);
    }
}

export class GroupCardContentSchemaBuilder extends ContentSchemaBuilder {
    schema: SchemaTypeDefinition = defineType({
        name: GroupCardContentDescriptor.schemaName,
        title: 'GroupCard',
        type: 'object',
        icon: Icon,
        fields: [
            defineField({
                type: 'string',
                name: 'title',
                title: 'Title',
            }),
            defineField({
                type: 'array',
                name: 'items',
                title: 'Items',
                of: [{type: CardTileContentDescriptor.schemaName}],
            }),
        ],
        preview: {
            select: {
                title: 'title',
                items: 'items',
            },
            prepare(selection: any) {
                return {
                    title: `Group Card: Items : (${selection.items.length}) (${selection.title ?? 'N/A'})`,
                };
            },
        },
    });

    constructor() {
        super(GroupCardContentDescriptor.schemaName);
    }

    build(descriptors: ContentDescriptor[]) {
        return this.schema;
    }
}

export class GroupIconContentSchemaBuilder extends ContentSchemaBuilder {
    schema: SchemaTypeDefinition = defineType({
        name: 'todo.group.icon.horizontal',
        title: 'GroupIcon',
        type: 'object',
        icon: Icon,
        fields: [
            defineField({
                type: 'string',
                name: 'title',
                title: 'Title',
            }),
        ],
        preview: {
            select: {
                title: 'title',
            },
            prepare(selection: any) {
                return {
                    title: `Group Icon Layout`,
                };
            },
        },
    });

    constructor() {
        super('todo.group.icon.horizontal');
    }

    build(descriptors: ContentDescriptor[]) {
        return this.schema;
    }
}
