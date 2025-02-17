import {FeatureDescriptor} from '@vyuh/sanity-schema-core';
import {RouteDescriptor} from '@vyuh/sanity-schema-system';
import {CardTileContentSchemaBuilder, TileContentDescriptor} from "./card-tile-content.ts";
import {tileListLayout} from "./tile_layout.ts";

export const tileSchema = new FeatureDescriptor({
    name: 'tile',
    title: 'Tile',
    description: 'Schema for the Tile feature',
    contents: [
        new RouteDescriptor({
            layouts: [tileListLayout],
            regionItems: [{type: TileContentDescriptor.schemaName}],
        }),
    ],
    contentSchemaBuilders: [new CardTileContentSchemaBuilder()],
});
