import { FeatureDescriptor } from '@vyuh/sanity-schema-core';
import { RouteDescriptor } from '@vyuh/sanity-schema-system';
import {CardTileContentSchemaBuilder, TileContentDescriptor} from "./simple-content.ts";

export const tileSchema = new FeatureDescriptor({
  name: 'tile',
  title: 'Tile',
  description: 'Schema for the Tile feature',
  contents: [
    new RouteDescriptor({
      regionItems: [{type: TileContentDescriptor.schemaName}],
    }),
  ],
  contentSchemaBuilders: [new CardTileContentSchemaBuilder()],
});
