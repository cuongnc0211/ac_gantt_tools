const RecursiveTasksInfo = (props) => {
  let task = props.task

  return(
    <React.Fragment key={task.id}>
      <TaskInfo task={task} />
      {task.childrent && task.childrent.map((child) => <RecursiveTasksInfo task={child} />)}
    </React.Fragment>
  )
}