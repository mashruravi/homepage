/**
 * Implement Gatsby's Node APIs in this file.
 *
 * See: https://www.gatsbyjs.org/docs/node-apis/
 */

// You can delete this file if you're not using it

const { createFilePath } = require('gatsby-source-filesystem');

// Automatically generate slugs for MDX files (blog posts)
exports.onCreateNode = ({ node, actions, getNode }) => {
  const { createNodeField } = actions;
  if (node.internal.type === 'Mdx' || node.internal.type === 'JupyterNotebook') {
    const value = createFilePath({ node, getNode });
    createNodeField({
      name: 'slug',
      node,
      value: `/blog${value}`,
    });
  }
};

const path = require('path');

// Create pages for blog posts
exports.createPages = async ({ graphql, actions, reporter }) => {
  const { createPage } = actions;
  const mdxResult = await graphql(`
    query {
      allMdx {
        edges {
          node {
            id
            fields {
              slug
            }
          }
        }
      }
    }
  `);

  const jupyterResult = await graphql(`
    query {
      allJupyterNotebook {
        edges {
          node {
            id
            fields {
              slug
            }
          }
        }
      }
    }
  `);

  if (mdxResult.errors) {
    reporter.panicOnBuild('🚨  ERROR: Loading "createPages" query for mdx posts');
  }

  if (jupyterResult.errors) {
    reporter.panicOnBuild('🚨  ERROR: Loading "createPages" query for jupyter posts');
  }

  const mdxPosts = mdxResult.data.allMdx.edges;

  mdxPosts.forEach(({ node }) => {
    createPage({
      path: node.fields.slug,
      component: path.resolve('./src/components/blog-layout.js'),
      context: { id: node.id }
    });
  });

  const jupyterPosts = jupyterResult.data.allJupyterNotebook.edges;

  jupyterPosts.forEach(({ node }) => {
    createPage({
      path: node.fields.slug,
      component: path.resolve('./src/components/jupyter-blog-layout.js'),
      context: { id: node.id }
    });
  });

};
