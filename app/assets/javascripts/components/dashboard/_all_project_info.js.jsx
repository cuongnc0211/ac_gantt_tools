const AllProjectInfo = (props) => {
  var projects = props.projects.map((project) => {
    return(
      <React.Fragment key={project.id}>
        <ProjectInfo project={project} />
      </React.Fragment>
    )
  })

  return(
    <React.Fragment>
      {projects}
    </React.Fragment>
  )
}
