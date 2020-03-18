class ProjectInfo extends React.Component{
  constructor(props){
    super(props);
  }

  render(){
    let tasks = this.props.project.tasks.map((task, index) => {
      return(
        <React.Fragment key={index}>
          <RecursiveTasksInfo task={task} />
        </React.Fragment>
      )
    });

    return(
      <React.Fragment key={this.props.project.id}>
        <tr className='tr-project-name'>
          <td className='header-project'>{this.props.project.name}</td>
          <td className='header-project'>Start</td>
          <td className='header-project'>Days</td>
          <td className='header-project'>End</td>
          <td className='header-project'>T.Progress</td>
          <td className='header-project'>Days left</td>
          <td className='header-project'>A.Progress(%)</td>
          <td className='header-project'>Status</td>
        </tr>
        {tasks}
      </React.Fragment>
    )
  }
}