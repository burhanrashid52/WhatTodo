import {defineType, SchemaTypeDefinition} from "sanity";
import {MdOutlineApps as Icon} from 'react-icons/md';

export const tileListLayout: SchemaTypeDefinition = defineType({
    name: 'tile.route.layout.list',
    title: 'Tile List Layout',
    type: 'object',
    icon: Icon,
    fields: [
        {
            name: 'title',
            title: 'Title',
            type: 'string',
        },

        {
            name: 'subtitle',
            title: 'Subtitle',
            type: 'string',
        },
    ],
});