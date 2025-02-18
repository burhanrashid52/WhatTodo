import {
  ContentDescriptor,
  ContentSchemaBuilder,
} from '@vyuh/sanity-schema-core';
import { defineField, defineType, SchemaTypeDefinition } from 'sanity';
import { IoIosRocket as Icon } from 'react-icons/io';

export class SimpleContentDescriptor extends ContentDescriptor {
  static schemaName = 'todoSchema.simple.content';

  constructor() {
    super(SimpleContentDescriptor.schemaName, {});
  }
}

export class SimpleContentSchemaBuilder extends ContentSchemaBuilder {
  schema: SchemaTypeDefinition = defineType({
    name: SimpleContentDescriptor.schemaName,
    title: 'Simple',
    type: 'object',
    icon: Icon,
    fields: [
      defineField({
        name: 'title',
        title: 'Title',
        type: 'string',
      }),
    ],
    preview: {
      select: {
        title: 'title',
      },
      prepare(selection: any) {
        return {
          title: `Simple: (${selection.title ?? 'N/A'})`,
        };
      },
    },
  });

  constructor() {
    super(SimpleContentDescriptor.schemaName);
  }

  build(descriptors: ContentDescriptor[]) {
    return this.schema;
  }
}
