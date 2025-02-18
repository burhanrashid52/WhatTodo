import {ContentDescriptor, ContentSchemaBuilder,} from '@vyuh/sanity-schema-core';
import {defineArrayMember, defineField, defineType, SchemaTypeDefinition} from 'sanity';
import {IoMdCard as Icon} from 'react-icons/io';

export class GroupCardContentDescriptor extends ContentDescriptor {
    static schemaName = 'todo.group.card';

    constructor() {
        super(GroupCardContentDescriptor.schemaName, {});
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
                type: 'array',
                name: 'items',
                title: 'Items',
                of: [
                    defineArrayMember({
                        type: 'object',
                        name: 'type-name-in-array',
                        fields: [
                            defineField({
                                type: 'string',
                                name: 'title',
                                title: 'Title'
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
                            })
                        ],
                    })],
            }),
        ],
        preview: {
            select: {
                title: 'title',
            },
            prepare(selection: any) {
                return {
                    title: `Group Card: (${selection.title ?? 'N/A'})`,
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
