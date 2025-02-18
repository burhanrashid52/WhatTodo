import { FeatureDescriptor } from '@vyuh/sanity-schema-core';
import { RouteDescriptor } from '@vyuh/sanity-schema-system';
import {SimpleContentDescriptor, SimpleContentSchemaBuilder} from './simple-content';

export const todoSchema = new FeatureDescriptor({
  name: 'todoSchema',
  title: 'Todo Schema',
  description: 'Schema for the Todo Schema feature',
  contents: [
    new RouteDescriptor({
      regionItems: [{ type: SimpleContentDescriptor.schemaName }],
    }),
  ],
  contentSchemaBuilders: [new SimpleContentSchemaBuilder()],
});
